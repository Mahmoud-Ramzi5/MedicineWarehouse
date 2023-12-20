<?php

namespace App\Http\Controllers\UserControllers;
use App\Http\Controllers\MedicinesController;

use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\Medicine;
use App\Models\Category;

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
        $medicines = Medicine::with('MedicineTranslations')->with('Categories')->get();
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
        $entries=[];
        foreach($valids as $valid){
            $medicinetranslation = $valid['MedicineTranslations'];
            foreach($medicinetranslation as $m){
                $commercial_name = $m['commercial_name'];
                $scientific_name = $m['scientific_name'];
                if($name == $commercial_name||$name == $scientific_name){
                array_push($entries,$valid);
                }
            }
        }if ($entries!=null){
            return response()->json(["message"=> $entries], 200);
            }
            else{return response()->json(["message"=> 'sorry item requested not found please check the name correctly'], 400);}
        }
}
