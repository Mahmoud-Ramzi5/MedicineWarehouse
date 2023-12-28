<?php

namespace App\Http\Controllers\UserControllers;
use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use App\Models\Medicine;
use App\Models\Order;
use App\Models\OrderedMedicine;
use App\Models\Favorite;
use Laravel\Sanctum\PersonalAccessToken;

function DoNothing() {;}

class OrderController extends Controller
{
    public function ShowOrders(Request $request)
    {
        $user =  auth('sanctum')->user();
        if ($user == null) {
            return response()->json([
                'message' => 'Invalid User'
            ], 400);
        }
        // Get user Favorite
        $favorite = Favorite::where('user_id', $user->id)->first();
        // User Orders
        $orders = Order::where('user_id', $user->id)->get();
        if ($orders->isEmpty()) {
            return response()->json([
                'message' => 'No orders yet'
            ], 400);
        }
        foreach ($orders as $order) {
            $medicines = $order->OrderedMedicines;
            foreach($medicines as $orderedMedicine) {
                $medicine = $orderedMedicine->Medicine;
                $medicine->MedicineTranslations;
                $medicine->Categories;
                if ($favorite->Medicines()->where('medicine_id', '=', $medicine->id)->exists()) {
                    $medicine['is_favorite'] = true;
                }
                else {
                    $medicine['is_favorite'] = false;
                }
            }
        }
        return response()->json([
            'message' => $orders
        ], 200)->header('Content-Type', 'application/json; charset=UTF-8');
    }

    public function Add_Order(Request $request)
    {
        // Validate request
        $validated = $request->validate([
            'medicines' => 'required'
        ]);
        $user =  auth('sanctum')->user();
        if ($user==null) {
            return response()->json([
                'message' => 'Invalid User'
            ], 400);
        }
        // Get user id
        $user_id = $user->id;
        // Check medicines and quantities
        $medicines = [];
        $total_price = 0.0;
        foreach ($validated['medicines'] as $index => $value) {
            array_push($medicines, $index);
            $medicine = Medicine::find($index);
            if ($medicine == null) {
                return response()->json([
                    'message' => 'Invalid Medicine'
                ], 400);
            }
            $quantity = $medicine->quantity_available;
            if ($quantity < $value) {
                return response()->json([
                    'message' => 'Quantity not available'
                ], 400);
            }
            $total_price += ($medicine->price) * $value;
        }
        // Create order
        $order = Order::create([
            'user_id' => $user_id,
            'status' => 'PREPARING',
            'is_paid' => false,
            'total_price' => $total_price
        ]);
        // Set new values
        foreach ($validated['medicines'] as $index => $value) {
            $ordered_medicine = OrderedMedicine::create([
                'order_id' => $order->id,
                'medicine_id' => $index,
                'quantity'=> $value
            ]);
            $medicine = Medicine::find($index);
            $quantity = $medicine->quantity_available;
            $reserved = $medicine->quantity_allocated;
            $medicine->quantity_available = $quantity - $value;
            $medicine->quantity_allocated = $reserved + $value;
            $medicine->save();
        }
        // Response
        return response()->json([
            'message' => 'Successfully ordered'
        ], 200);
    }
}
