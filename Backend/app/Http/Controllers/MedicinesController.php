<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\MedicineTranslation;
use Illuminate\Http\Request;
use App\Models\Medicine;

class MedicinesController extends Controller
{
    public function ShowNotExpired(Request $request)
    {
        $medicines = Medicine::with('MedicineTranslations')->with('Categories')->get();
        $valid = [];
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
            else
            {
                if ($medicineMonth > $dateMonth)
                {
                    array_push($valid, $medicine);
                }
                else
                {
                    if ($medicineDay > $dateDay)
                    {
                        array_push($valid, $medicine);
                    }
                }
            }
        }
        return response()->json([
            'data' => $valid
        ], 200);
    }

    public function ShowAll(Request $request)
    {
        $medicines = Medicine::with('MedicineTranslations')->with('Categories')->get();
        return response()->json([
            'data' => $medicines
        ], 200);
    }

    public function Selected_Category(Request $request)
    {
        // find the selected category
        $id = $request->input('id');
        $category = Category::find($id);
        //find the medicines with the selected category
        $medicines = $category->Medicines;
        $data = [];
        foreach($medicines as $medicine){

            $medicinesData =[
                $medicine,
                MedicineTranslation::where('medicine_id', $medicine->id)->get()
            ];
            array_push($data, $medicinesData);
        }
        // Response
        return response()->json([
            'message' => $data,
        ], 200);
    }

    public function Display_Medicine_info(Request $request){
        $id = $request->input('id');
        $medicine = Medicine::find($id);
        $medicine->MedicineTranslations;
        $medicine->Categories;
        return response()->json(["message"=> $medicine], 200);
    }


    function Search_All(Request $request){
        $name = $request->input('name');
        $medicines = Medicine::with('MedicineTranslations')->with('Categories')->get();
        foreach ($medicines as $medicine) {
            $commercial_name = $medicine->commercial_name;
            $scientific_name = $medicine->scientific_name;
            if($name == $commercial_name||$name == $scientific_name){
                return response()->json(["message"=> $medicine], 200);
            }

        }
        return response()->json(["message"=> 'sorry item requested not found it may be out of stock or expired'], 200);
    }

    function Search_Not_Expired(Request $request){
        $name = $request->input('name');
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
            else
            {
                if ($medicineMonth > $dateMonth)
                {
                    array_push($valids, $medicine);
                }
                else
                {
                    if ($medicineDay > $dateDay)
                    {
                        array_push($valids, $medicine);
                    }
                }
            }
        }
        foreach($valids as $valid){
            $commercial_name = $valid->commercial_name;
            $scientific_name = $valid->scientific_name;

            if($name == $commercial_name||$name == $scientific_name){
                return response()->json(["message"=> $medicine], 200);
            }

        }
        return response()->json(["message"=> 'sorry item requested not found it may be out of stock or expired'], 200);
}
}

