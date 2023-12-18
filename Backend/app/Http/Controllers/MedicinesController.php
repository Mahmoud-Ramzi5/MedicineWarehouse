<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Medicine;
use App\Models\Category;

class MedicinesController extends Controller
{
    public function Categories(Request $request)
    {
        // Retrieve all categories
        $categories = category::all();
        return response()->json([
            'message' => $categories
        ], 200)->header('Content-Type', 'application/json; charset=UTF-8');
    }

    public function DisplayMedicineInfo(Request $request)
    {
        // Get medicine id
        $id = $request->input('id');
        // Find medicine
        $medicine = Medicine::find($id);
        if ($medicine == null) {
            return response()->json([
                'message' => 'Invalid Medicine'
            ], 400);
        }
        $medicine->MedicineTranslations;
        $medicine->Categories;
        // Response
        return response()->json([
            "message" => $medicine
        ], 200)->header('Content-Type', 'application/json; charset=UTF-8');
    }

    public function GG(Request $request)
    {
        return response()->json(["message"=>$request->Input("medicines")], 200);
    }

}

