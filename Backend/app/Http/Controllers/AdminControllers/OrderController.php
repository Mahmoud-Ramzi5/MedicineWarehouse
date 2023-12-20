<?php

namespace App\Http\Controllers\AdminControllers;
use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use App\Enums\OrderEnum;
use App\Models\Order;

function DoNothing() {;}

class OrderController extends Controller
{
    public function ShowAll()
    {
        // All Orders
        $orders = Order::with('User')->get();
        foreach ($orders as $order) {
            $medicines = $order->OrderedMedicines;
            foreach($medicines as $orderedMedicine) {
                $medicine = $orderedMedicine->Medicine;
                $medicine->MedicineTranslations;
                $medicine->Categories;
            }
        }
        return response()->json([
            'message' => $orders
        ], 200)->header('Content-Type', 'application/json; charset=UTF-8');
    }

    public function Update_Order(Request $request)
    {
        $message = "";
        $validated = $request->validate([
            'id' => 'required',
            'status' => ['required', Rule::enum(OrderEnum::class)],
            'is_paid' => 'required'
        ]);
        $id = $validated['id'];
        $status = $validated['status'];
        $order = Order::find($id);
        if ($order == null) {
            return response()->json([
                'message' => 'Invalid Order'
            ], 400);
        }

        if ($order->is_paid == 0 && $validated['is_paid'] == 1) {
            $order->is_paid = $validated['is_paid'];
            $order->save();
            $message = "Updated order pay status & ";
        }
        else if ($order->is_paid == $validated['is_paid']) {
            DoNothing();
        }
        else {
            return response()->json([
                'message' => 'User already paid for Order',
            ], 400);
        }

        if ($order->status == $status) {
            DoNothing();
        }
        else if ($order->status == 'RECEIVED') {
            return response()->json([
                'message' => $message . 'Order has already been SENT and RECEIVED',
            ], 400);
        }
        else {
            if ($order->status == 'PREPARING') {
                if ($status == 'SENT') {
                    $medicines = $order->Medicines;
                    foreach ($medicines as $medicine) {
                        $ordered_medicine =  $order->OrderedMedicine()->where('medicine_id', $medicine->id)->first();
                        $total_quantity = $medicine->quantity_total;
                        $allocated_quantity = $medicine->quantity_allocated;
                        $medicine->quantity_total = $total_quantity - ($ordered_medicine->quantity);
                        $medicine->quantity_allocated = $allocated_quantity - ($ordered_medicine->quantity);
                        $medicine->save();
                    }
                    $order->update([
                        'status' => $status
                    ]);
                }
                else {
                    return response()->json([
                        'message' => $message . 'Invalid Order Status',
                    ], 400);
                }
            }
            else if ($order->status == 'SENT') {
                if ($status == 'RECEIVED') {
                    $order->update([
                        'status' => $status
                    ]);
                }
                else {
                    return response()->json([
                        'message' => $message . 'Invalid Order Status',
                    ], 400);
                }
            }
            else {
                return response()->json([
                    'message' => $message . 'Could not update order status; Unknown Error',
                ], 400);
            }
        }
        return response()->json([
            'message' => 'Successfully: ' . $message . 'updated order status',
        ], 200);

    }
}
