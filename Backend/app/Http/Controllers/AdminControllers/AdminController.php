<?php

namespace App\Http\Controllers\AdminControllers;
use App\Http\Controllers\Controller;

use App\Http\Requests\MedicineRequest;
use Illuminate\Http\Request;
use App\Models\Category;
use App\Models\Medicine;
use App\Models\MedicineTranslation;
use App\Http\Requests\AdminRequests\LoginAdminRequest;
use Illuminate\Support\Str;

class AdminController extends Controller
{
    /*function login(LoginAdminRequest $request)
    {
        $credentials = $request->validated();
        $admin_name = 'Ghassan@gmail.com';
        $admin_passwowrd = 5554321;
        $email = $credentials['email'];
        $password = $credentials['password'];
        if ($email != $admin_name || $password != $admin_passwowrd) {
            return response()->json([
                'message' => 'Invalid credentials',
                'errors' => [
                    'Email & Password' => [
                        'Passwords does not match.'
                    ],
                ]
            ], 400);
        }
        // Login User
        return response()->json([
            'message' => 'Successfully logged in',
            'access_token' => '',
        ], 200);
    }*/


    public function Add_Medicine(MedicineRequest $request)
    {
        // Validate Input
        $credentials = $request->validated();
        // Create Medicine
        $medicine = Medicine::create([
            'expiry_date' => $credentials['expiry_date'],
            'quantity_available' => $credentials['quantity_available'],
            'price' => $credentials['price'],
        ]);
        $medicine->Categories()->attach($credentials['category_id']);
        // Create English Translation
        $En = MedicineTranslation::create([
            'medicine_id'=> $medicine->id,
            'lang'=> 'en',
            'commercial_name' => Str::upper($credentials['en_commercial_name']),
            'scientific_name' =>  Str::upper($credentials['en_scientific_name']),
            'manufacture_company' =>  Str::upper($credentials['en_manufacture_company']),
        ]);
        // Create Arabic Translation
        $Ar = MedicineTranslation::create([
            'medicine_id'=> $medicine->id,
            'lang'=> 'ar',
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

    public function Add_Categories(Request $request)
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
    }

}
