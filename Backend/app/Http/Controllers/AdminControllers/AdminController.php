<?php

namespace App\Http\Controllers\AdminControllers;
use App\Http\Controllers\Controller;

use App\Http\Requests\MedicineRequest;
use Illuminate\Http\Request;
use App\Models\Admin;
use App\Models\Category;
use App\Models\Medicine;
use App\Models\MedicineTranslation;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

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

        /*if ($credentials['image']) {
            $path = 'public/'.$credentials['image_path'];
            $image = base64_decode($credentials['image']);
            Storage::put($path, $image);
        }
        else {
            $path = 'public/default.png';
        }*/

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
        $medicine->delete();
        // Response
        return response()->json([
            'message' => 'Successfully deleted medicine',
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
