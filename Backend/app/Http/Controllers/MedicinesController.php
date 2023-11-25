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
            $medicineYear = $medicine->Expiry_date->format('Y');
            $medicineMonth = $medicine->Expiry_date->format('m');
            $medicineDay = $medicine->Expiry_date->format('d');

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
}
