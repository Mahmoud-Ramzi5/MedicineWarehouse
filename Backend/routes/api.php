<?php

use App\Http\Controllers\MedicinesController;
use App\Http\Controllers\UserControllers\UserController;
use App\Http\Controllers\UserControllers\UserMedicinesController;
use App\Http\Controllers\UserControllers\OrderController as UserOrderController;
use App\Http\Controllers\UserControllers\FavoriteController;
use App\Http\Controllers\AdminControllers\AdminController;
use App\Http\Controllers\AdminControllers\AdminMedicinesController;
use App\Http\Controllers\AdminControllers\OrderController as AdminOrderController;
use App\Http\Controllers\AdminControllers\ReportController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// User Routes
Route::prefix('/users')->group(function () {
    Route::controller(UserController::class)->group(function () {
        Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
            return $request->user();
        });

        Route::post('/register', 'register')->name('register');
        Route::post('/login', 'login')->name('login');
        Route::middleware('auth:sanctum')->post('/logout', 'logout')->name('logout');
    });
    Route::controller(UserMedicinesController::class)->group(function () {
        Route::get('/medicines', 'ShowNotExpired')->name('ShowNotExpired_Medicines');
        Route::get('/categories', 'Categories')->name('Categories');
        Route::post('/categoryFilter', 'Selected_Category');

        Route::post('/medicineInfo', 'DisplayMedicineInfo')->name('DisplayMedicineInfo');

        Route::post('/search', 'Search_Not_Expired')->name('Search_Not_Expired');
    });
    Route::controller(UserOrderController::class)->group(function () {
        Route::get('/orders', 'ShowOrders')->name('ShowUserOrders');
        Route::post('/new_order', 'Add_Order')->name('Add_Order');
    });
    Route::controller(FavoriteController::class)->group(function(){
        Route::get('/favorite', 'DisplayFavorite')->name('DisplayFavorite');
        Route::post('/addFavorite', 'AddToFavorite')->name('AddToFavorite');
        Route::post('/removeFavorite', 'DeleteFavorite')->name('DeleteFavorite');
    });
});


// Admin Routes
Route::prefix('/admin')->group(function () {
    Route::controller(AdminController::class)->group(function () {
        Route::post('/login', 'login')->name('AdminLogin');
        Route::middleware('auth:sanctum')->post('/logout', 'logout')->name('AdminLogout');
    });
    Route::controller(AdminMedicinesController::class)->group(function () {
        Route::get('/medicines', 'ShowAll')->name('ShowAll_Medicines');
        Route::get('/categories', 'Categories')->name('Categories');
        Route::post('/categoryFilter', 'Selected_Category');
        Route::post('/new_medicine', 'Add_Medicine')->name('Add_Medicine');
        Route::delete('/delete_medicine', 'Delete_Medicine')->name('Delete_Medicine');

        Route::post('/medicineInfo', 'DisplayMedicineInfo')->name('DisplayMedicineInfo');

        Route::post('/search', 'Search_All')->name('Search_All');
    });
    Route::controller(AdminOrderController::class)->group(function () {
        Route::get('/orders', 'ShowAll')->name('ShowAll_Orders');
        Route::post('/update_order', 'Update_Order')->name('Update_Order');
    });
    Route::post('/reports', [ReportController::class, 'Show'])->name('Show_Reports');
});

// Test Route
Route::post('/GG', [MedicinesController::class, 'GG'])->name('GG');
