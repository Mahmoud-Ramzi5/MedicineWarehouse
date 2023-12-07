<?php

namespace App\Http\Controllers;

use Illuminate\Support\Str;
use App\Models\Category;
use App\Models\MedicineTranslation;
use Illuminate\Http\Request;
use App\Models\Medicine;

class MedicinesController extends Controller
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

    public function ShowAll(Request $request)
    {
        // All Medicines
        $medicines = Medicine::with('MedicineTranslations')->with('Categories')->get();
        return response()->json([
            'data' => $medicines
        ], 200)->header('Content-Type', 'application/json; charset=UTF-8');
    }

    public function Categories(Request $request)
    {
        // Retrieve all categories
        $categories = category::all();
        return response()->json([
            "message"=>$categories
        ], 200)->header('Content-Type', 'application/json; charset=UTF-8');
    }

    public function Selected_Category(Request $request)
    {
        // find the selected category
        $id = $request->input('id');
        $category = Category::find($id);
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

    public function DisplayMedicineInfo(Request $request)
    {
        // Get medicine id
        $id = $request->input('id');
        // Find medicine
        $medicine = Medicine::find($id);
        $medicine->MedicineTranslations;
        $medicine->Categories;
        // Response
        return response()->json([
            "message" => $medicine
        ], 200)->header('Content-Type', 'application/json; charset=UTF-8');
    }




    function Search_All(Request $request){
        $input = $request->input('name');
        $name = Str::upper($input);
        $medicines = Medicine::with('MedicineTranslations')->with('Categories')->get();
        foreach ($medicines as $medicine) {
            $medicinetranslation = $medicine['MedicineTranslations'];
            foreach($medicinetranslation as $m){
                $commercial_name = $m['commercial_name'];
                $scientific_name = $m['$scientific_name'];
                if($name == $commercial_name||$name == $scientific_name){
                    return response()->json(["message"=> $medicine], 200);
                }
            }
        }
        return response()->json(["message"=> 'sorry item requested not found please check the name correctly'], 400);
    }

    function Search_Not_Expired(Request $request){
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
        foreach($valids as $valid){
            $medicinetranslation = $valid['MedicineTranslations'];
            foreach($medicinetranslation as $m){
                $commercial_name = $m['commercial_name'];
                $scientific_name = $m['$scientific_name'];
                if($name == $commercial_name||$name == $scientific_name){
                    return response()->json(["message"=> $medicine], 200);
                }
            }
        }
        return response()->json(["message"=> 'sorry item requested not found it may be out of stock or expired'], 400);
    }

public function GG(Request $request){

    return response()->json(["message"=>$request->Input("medicines")], 200);
}

}

