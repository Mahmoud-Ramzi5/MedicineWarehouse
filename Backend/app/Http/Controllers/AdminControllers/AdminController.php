<?php

namespace App\Http\Controllers\AdminControllers;
use App\Http\Controllers\Controller;

use App\Http\Requests\MedicineRequest;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use App\Enums\OrderEnum;
use App\Models\Admin;
use App\Models\Order;
use App\Models\Category;
use App\Models\Medicine;
use App\Models\MedicineTranslation;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

function DoNothing() {;}
class AdminController extends Controller
{

    function login(Request $request)
    {
        // Validate Input
        $credentials = $request->validate([
            'userName' => 'required',
            'password' => 'required',
        ]);
        $admin = Admin::where('warehouseName', $credentials['userName'])->first();
        if (! $admin || ! Hash::check($credentials['password'], $admin->password)) {
            return response()->json([
                'message' => 'Invalid credentials',
                'errors' => [
                    'phoneNumber & password' => [
                        'Invalid phone-number or password.'
                    ],
                ]
            ], 400);
        }
        // Handle Remember Me functionality
        if ($request->input("rememberMe")) {
            $authToken = $admin->createToken(name:'auth-token', expiresAt:now()->addMonths(3))->plainTextToken;
        }
        else {
            $authToken = $admin->createToken(name:'auth-token', expiresAt:now()->addHours(3))->plainTextToken;
        }
        // Login Admin
        return response()->json([
            'message' => 'Successfully logged in',
            'access_token' => $authToken,
        ], 200);
    }

    function Logout(Request $request)
    {
        // Logout Admin
        $request->user()->currentAccessToken()->delete();
        return response()->json([
            'message' => 'Successfully logged out',
        ], 200);
    }

    public function Add_Medicine(MedicineRequest $request)
    {
        // Validate Input
        $credentials = $request->validated();
        // Store Image
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $path = 'public/'.$credentials['image_path'];
            if (!Storage::exists($path)) {
                Storage::put($path, file_get_contents($image));
            }
        } else {
            $path = 'public/'.$credentials['image_path'];
        }
        // Create Medicine
        $medicine = Medicine::create([
            'expiry_date' => $credentials['expiry_date'],
            'quantity_total' => $credentials['quantity_available'],
            'quantity_allocated' => 0,
            'quantity_available' => $credentials['quantity_available'],
            'price' => $credentials['price'],
            'image_path' => $path,
        ]);
        $medicine->Categories()->attach(explode(",", $credentials['category_ids']));
        // Create English Translation
        $En = MedicineTranslation::create([
            'medicine_id' => $medicine->id,
            'lang' => 'en',
            'commercial_name' => Str::upper($credentials['en_commercial_name']),
            'scientific_name' =>  Str::upper($credentials['en_scientific_name']),
            'manufacture_company' =>  Str::upper($credentials['en_manufacture_company']),
        ]);
        // Create Arabic Translation
        $Ar = MedicineTranslation::create([
            'medicine_id' => $medicine->id,
            'lang' => 'ar',
            'commercial_name' => $credentials['ar_commercial_name'],
            'scientific_name' => $credentials['ar_scientific_name'],
            'manufacture_company' => $credentials['ar_manufacture_company'],
        ]);
        // Response
        return response()->json([
            'message' => 'Successfully added medicine',
        ], 200);
    }

    public function Delete_Medicine(Request $request)
    {
        // Delete Medicine
        $id = $request->input('id');
        $medicine = Medicine::find($id);
        if ($medicine == null) {
            return response()->json([
                'message' => 'Invalid Medicine'
            ], 400);
        }
        $medicine->delete();
        // Response
        return response()->json([
            'message' => 'Successfully deleted medicine',
        ], 200);
    }

    public function Update_Order(Request $request) {
        $message = "";
        $validated = $request->validate([
            'id' => 'required',
            'status' => ['required', Rule::enum(OrderEnum::class)],
            'is_paid' => 'required'
        ]);
        $id = $validated['id'];
        $status = $validated['status'];
        $order = Order::find($id);
        if ($order == null) {
            return response()->json([
                'message' => 'Invalid Order'
            ], 400);
        }

        if ($order->is_paid == 0 && $validated['is_paid'] == 1) {
            $order->is_paid = $validated['is_paid'];
            $order->save();
            $message = "Updated order pay status & ";
        }
        else if ($order->is_paid == $validated['is_paid']) {
            DoNothing();
        }
        else {
            return response()->json([
                'message' => 'User already paid for Order',
            ], 400);
        }

        if ($order->status == $status) {
            DoNothing();
        }
        else if ($order->status == 'RECEIVED') {
            return response()->json([
                'message' => $message . 'Order has already been SENT and RECEIVED',
            ], 400);
        }
        else {
            if ($order->status == 'PREPARING') {
                if ($status == 'SENT') {
                    $medicines = $order->Medicines;
                    foreach ($medicines as $medicine) {
                        $ordered_medicine =  $order->OrderedMedicine()->where('medicine_id', $medicine->id)->first();
                        $total_quantity = $medicine->quantity_total;
                        $allocated_quantity = $medicine->quantity_allocated;
                        $medicine->quantity_total = $total_quantity - ($ordered_medicine->quantity);
                        $medicine->quantity_allocated = $allocated_quantity - ($ordered_medicine->quantity);
                        $medicine->save();
                    }
                    $order->update([
                        'status' => $status
                    ]);
                }
                else {
                    return response()->json([
                        'message' => $message . 'Invalid Order Status',
                    ], 400);
                }
            }
            else if ($order->status == 'SENT') {
                if ($status == 'RECEIVED') {
                    $order->update([
                        'status' => $status
                    ]);
                }
                else {
                    return response()->json([
                        'message' => $message . 'Invalid Order Status',
                    ], 400);
                }
            }
            else {
                return response()->json([
                    'message' => $message . 'Could not update order status; Unknown Error',
                ], 400);
            }
        }
        return response()->json([
            'message' => 'Successfully: ' . $message . 'updated order status',
        ], 200);

    }

    /*public function Add_Categories(Request $request)
    {
        $fileContent = file_get_contents(storage_path("Categories.json"));
        $jsonContent = json_decode($fileContent, true);
        foreach($jsonContent as $category)
        {
            $category = Category::create([
                "en_category_name" => $category["en_category_name"],
                "ar_category_name" => $category["ar_category_name"],
                "en_description" => $category["en_description"],
                "ar_description" => $category["ar_description"]
            ]);
        }
    }*/

    /*public function Add_Medicines(Request $request)
    {
        $fileContent = file_get_contents(storage_path("Medicines.json"));
        $jsonContent = json_decode($fileContent, true);
        foreach($jsonContent as $medicine)
        {
            $M =  Medicine::create([
                "expiry_date" => $medicine["expiry_date"],
                "quantity_total"=> $medicine["quantity_available"],
                "quantity_allocated"=> 0,
                "quantity_available"=> $medicine["quantity_available"],
                "price"=> $medicine["price"],
                "image_path"=> $medicine["image_path"],
            ]);
            $M->Categories()->attach($medicine["category_ids"]);
            $En = MedicineTranslation::create([
                'medicine_id' => $M->id,
                'lang' => 'en',
                'commercial_name' => Str::upper($medicine["en_commercial_name"]),
                'scientific_name' =>  Str::upper($medicine["en_scientific_name"]),
                'manufacture_company' =>  Str::upper($medicine["en_manufacture_company"]),
            ]);
            $Ar = MedicineTranslation::create([
                'medicine_id' => $M->id,
                'lang' => 'ar',
                'commercial_name' => $medicine["ar_commercial_name"],
                'scientific_name' => $medicine["ar_scientific_name"],
                'manufacture_company' => $medicine["ar_manufacture_company"],
            ]);
        }
    }*/


}
