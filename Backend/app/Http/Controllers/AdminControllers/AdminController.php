<?php

namespace App\Http\Controllers\AdminControllers;
use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use App\Models\Admin;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

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

/*    public function Add_Categories(Request $request)
    {
        $fileContent = file_get_contents(storage_path("Categories.json"));
        $jsonContent = json_decode($fileContent, true);
        foreach($jsonContent as $category)
        {
            $c = Category::create([
                "en_category_name" => $category["en_category_name"],
                "ar_category_name" => $category["ar_category_name"],
                "en_description" => $category["en_description"],
                "ar_description" => $category["ar_description"]
            ]);
        }
    }

    public function Add_Medicines(Request $request)
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
