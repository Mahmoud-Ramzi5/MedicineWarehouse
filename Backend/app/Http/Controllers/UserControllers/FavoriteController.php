<?php

namespace App\Http\Controllers\UserControllers;
use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use App\Models\Medicine;
use App\Models\Favorite;

class FavoriteController extends Controller
{
    public function AddToFavorite(Request $request)
    {
        // Validate request
        $validated = $request->validate([
            'medicines' => 'required'
        ]);
        $user =  auth('sanctum')->user();
        if ($user == null) {
            return response()->json([
                'message' => 'Invalid User'
            ], 400);
        }
        // Get user id
        $user_id = $user->id;
        $favorite = Favorite::where('user_id', $user_id)->first();
        // Check medicines
        $medicines = [];
        foreach ($validated['medicines'] as $index) {
            array_push($medicines, $index);
            $medicine = Medicine::find($index);
            if ($medicine == null) {
                return response()->json([
                    'message' => 'Invalid Medicine'
                ], 400);
            }
        }
        $favorite->Medicines()->attach($medicines);
// Response
return response()->json([
    'message' => 'Successfully Added To Favorite'
], 200);
    }
public function DeleteFavorite(Request $request){
//will do it later
}

}

