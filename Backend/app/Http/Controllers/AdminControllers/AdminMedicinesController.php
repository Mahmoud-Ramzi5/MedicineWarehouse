<?php

namespace App\Http\Controllers\AdminControllers;
use App\Http\Controllers\MedicinesController;

use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Http\Requests\MedicineRequest;
use App\Models\Medicine;
use App\Models\MedicineTranslation;
use App\Models\Category;
use Illuminate\Support\Facades\Storage;

class AdminMedicinesController extends MedicinesController
{
    public function ShowAll()
    {
        // All Medicines
        $medicines = Medicine::with('MedicineTranslations')->with('Categories')->get();
        return response()->json([
            'data' => $medicines
        ], 200)->header('Content-Type', 'application/json; charset=UTF-8');
    }

    public function Selected_Category(Request $request)
    {
        // find the selected category
        $id = $request->input('id');
        $category = Category::find($id);
        if ($category == null) {
            return response()->json([
                'message' => 'Invalid Category'
            ], 400);
        }
        //find the medicines with the selected category
        $medicines = $category->Medicines;
        foreach($medicines as $medicine) {
            $medicine->MedicineTranslations;
            $medicine->Categories;
        }
        // Response
        return response()->json([
            'message' => $medicines,
        ], 200)->header('Content-Type', 'application/json; charset=UTF-8');
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

    function Search_All(Request $request)
    {
        $input = $request->input('name');
        $name = Str::upper($input);
        $medicines = Medicine::with('MedicineTranslations')->with('Categories')->get();
        $entries=[];
        foreach ($medicines as $medicine) {
            $medicinetranslation = $medicine['MedicineTranslations'];
            foreach($medicinetranslation as $m){
                $commercial_name = $m['commercial_name'];
                $scientific_name = $m['scientific_name'];
                if($name == $commercial_name||$name == $scientific_name){
                    array_push($entries,$medicine);
                }
            }
        }
        if ($entries!=null){
        return response()->json(["message"=> $entries], 200);
        }
        else{return response()->json(["message"=> 'sorry item requested not found please check the name correctly'], 400);}
    }
}
