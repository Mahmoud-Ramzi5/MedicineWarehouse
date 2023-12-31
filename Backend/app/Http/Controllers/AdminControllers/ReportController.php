<?php

namespace App\Http\Controllers\AdminControllers;
use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use App\Models\Medicine;
use App\Models\Order;

class ReportController extends Controller
{
    public function Show(Request $request)
    {
        $message = [];
        // Validate Input
        $validated = $request->validate([
            'start_date' => 'required',
            'end_date' => 'required'
        ]);

        /* Report 1 */
        $income = 0.0;
        $order_count = 0;
        $medicines_count = collect();

        // All Orders
        $orders = Order::with('User')->whereDate('created_at', '>=', $validated['start_date'])
                                        ->whereDate('created_at', '<=', $validated['end_date'])->get();
        if ($orders->isEmpty()) {
            $message['income'] = $income;
            $message['order_count'] = $order_count;
        }
        else {
            foreach ($orders as $order) {
                $order_count += 1;
                $income += $order->total_price;
                $medicines = $order->OrderedMedicines;
                foreach($medicines as $orderedMedicine) {
                    if ($medicines_count->contains('id', $orderedMedicine->medicine_id)) {
                        $medicines_count = $medicines_count->map(function ($item) use ($orderedMedicine) {
                            if ($item['id'] == $orderedMedicine->medicine_id) {
                                $item['count'] += $orderedMedicine->quantity;
                            }
                            return $item;
                        });
                    }
                    else {
                        $medicines_count->push([
                            'id' => $orderedMedicine->medicine_id,
                            'count' => $orderedMedicine->quantity
                        ]);
                    }
                }
            }
            // Get Id of most ordered Medicine
            $Med = $medicines_count->firstWhere('count', $medicines_count->max('count'));
            $Med_count = $Med['count'];
            // Get Medicine
            $medicine = Medicine::find($Med['id']);
            $medicine->MedicineTranslations;
            $medicine->Categories;

            $message['income'] = $income;
            $message['order_count'] = $order_count;
            $message['most_ordered_medicine'] = $medicine;
            $message['most_ordered_medicine_count'] = $Med_count;
        }
        /* Report 2 */
        // Expired Medicines this period of time
        $expired_medicines = Medicine::with('MedicineTranslations')->with('Categories')
                                        ->whereDate('expiry_date', '>=', $validated['start_date'])
                                        ->whereDate('expiry_date', '<=', $validated['end_date'])->get();

        if (!$expired_medicines->isEmpty()) {
            $message['expired_medicines'] = $expired_medicines;
        }
        // Response
        return response()->json([
            'message' => $message
        ],200);
    }
}
