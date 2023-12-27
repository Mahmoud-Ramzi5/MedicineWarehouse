<?php

namespace App\Http\Controllers\UserControllers;
use App\Http\Controllers\MedicinesController;

use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\Medicine;
use App\Models\Category;
use App\Models\MedicineTranslation;

class UserMedicinesController extends MedicinesController
{
    public function ShowNotExpired(Request $request)
    {
        // Fetch medicines from database
        $medicines = Medicine::with('MedicineTranslations')->with('Categories')->get();
        $valid = [];
        $Date = today();
        $dateYear = $Date->format('Y');
        $dateMonth = $Date->format('m');
        $dateDay = $Date->format('d');
        // Fetch (Only Not Expired) medicines
        foreach ($medicines as $medicine) {
            $medicineYear = $medicine->expiry_date->format('Y');
            $medicineMonth = $medicine->expiry_date->format('m');
            $medicineDay = $medicine->expiry_date->format('d');

            if ($medicineYear > $dateYear)
            {
                array_push($valid, $medicine);
            }
            elseif($medicineYear == $dateYear && $medicineMonth > $dateMonth)
            {
                array_push($valid, $medicine);
            }
            elseif($medicineYear == $dateYear && $medicineMonth == $dateMonth && $medicineDay > $dateDay)
            {
                array_push($valid, $medicine);
            }
        }
        // Not Expired Medicines
        return response()->json([
            'data' => $valid
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
        // Find the medicines with the selected category
        $medicines = $category->Medicines;
        foreach($medicines as $medicine) {
            $medicine->MedicineTranslations;
            $medicine->Categories;
        }
        $valid = [];
        $Date = today();
        $dateYear = $Date->format('Y');
        $dateMonth = $Date->format('m');
        $dateDay = $Date->format('d');
        // Fetch (Only Not Expired) medicines
        foreach ($medicines as $medicine) {
            $medicineYear = $medicine->expiry_date->format('Y');
            $medicineMonth = $medicine->expiry_date->format('m');
            $medicineDay = $medicine->expiry_date->format('d');

            if ($medicineYear > $dateYear)
            {
                array_push($valid, $medicine);
            }
            elseif($medicineYear == $dateYear && $medicineMonth > $dateMonth)
            {
                array_push($valid, $medicine);
            }
            elseif($medicineYear == $dateYear && $medicineMonth == $dateMonth && $medicineDay > $dateDay)
            {
                array_push($valid, $medicine);
            }
        }
        // Not Expired Medicines
        return response()->json([
            'data' => $valid
        ], 200)->header('Content-Type', 'application/json; charset=UTF-8');
    }

    function Search_Not_Expired(Request $request)
    {
        $input = $request->input('name');
        $name = Str::upper($input);
        $query = MedicineTranslation::where('commercial_name', 'like', "%$input%")
                                        ->orWhere('scientific_name', 'like', "%$input%")->get();
        $medicines = [];
        foreach ($query as $q) {
            $id = $q->medicine_id;
            $medicine = Medicine::find($id);
            $medicine->MedicineTranslations;
            $medicine->Categories;
            array_push($medicines, $medicine);
        }

        $valids = [];
        $Date = today();
        $dateYear = $Date->format('Y');
        $dateMonth = $Date->format('m');
        $dateDay = $Date->format('d');
        foreach ($medicines as $medicine) {
            $medicineYear = $medicine->expiry_date->format('Y');
            $medicineMonth = $medicine->expiry_date->format('m');
            $medicineDay = $medicine->expiry_date->format('d');

            if ($medicineYear > $dateYear)
            {
                array_push($valids, $medicine);
            }
            elseif($medicineYear == $dateYear && $medicineMonth > $dateMonth)
            {
                array_push($valids, $medicine);
            }
            elseif($medicineYear == $dateYear && $medicineMonth == $dateMonth && $medicineDay > $dateDay)
            {
                array_push($valids, $medicine);
            }
        }
        if ($valids!=null){
            return response()->json(["message"=> $valids], 200);
            }
            else{
                return response()->json(["message"=> 'sorry item requested not found please check the name correctly'], 400);
            }
        }
}

