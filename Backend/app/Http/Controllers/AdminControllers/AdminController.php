<?php

namespace App\Http\Controllers\AdminControllers;
use App\Http\Controllers\Controller;

use App\Http\Requests\MedicineRequest;
use Illuminate\Http\Request;
use App\Models\Category;
use App\Models\Medicine;
use App\Models\MedicineTranslation;

class AdminController extends Controller
{
    public function Add_Medicine(MedicineRequest $request)
    {
        // Validate Input
        $credentials = $request->validated();
        // Create Medicine
        $medicine = Medicine::create([
            'Expiry_date' => $credentials['Expiry_date'],
            'Quantity_available' => $credentials['Quantity_available'],
            'Price' => $credentials['Price'],
        ]);
        $medicine->Categories()->attach($credentials['Category_id']);
        // Create English Translation
        $En = MedicineTranslation::create([
            'medicine_id'=> $medicine->id,
            'lang'=> 'en',
            'Commercial_name' => $credentials['En_Commercial_name'],
            'Scientific_name' => $credentials['En_Scientific_name'],
            'Manufacture_company' => $credentials['En_Manufacture_company'],
        ]);
        // Create Arabic Translation
        $Ar = MedicineTranslation::create([
            'medicine_id'=> $medicine->id,
            'lang'=> 'ar',
            'Commercial_name' => $credentials['Ar_Commercial_name'],
            'Scientific_name' => $credentials['Ar_Scientific_name'],
            'Manufacture_company' => $credentials['Ar_Manufacture_company'],
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
                "En_Category_name" => $category["En_Category_name"],
                "Ar_Category_name" => $category["Ar_Category_name"],
                "En_Description" => $category["En_Description"],
                "Ar_Description" => $category["Ar_Description"]
            ]);
        }
    }

}
