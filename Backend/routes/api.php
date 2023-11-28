<?php

use App\Http\Controllers\MedicinesController;
use App\Http\Controllers\UserControllers\UserController;
use App\Http\Controllers\AdminControllers\AdminController;
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

Route::prefix('/users')->group(function () {
    Route::controller(UserController::class)->group(function () {
        Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
            return $request->user();
        });

        Route::post('/register', 'register')->name('register');
        Route::post('/login', 'login')->name('login');
        Route::middleware('auth:sanctum')->post('/logout', 'logout')->name('logout');
    });
    Route::controller(MedicinesController::class)->group(function () {
        Route::middleware('auth:sanctum')->get('/medicines', 'ShowNotExpired')->name('ShowNotExpired');
        Route::get('/categoryFilter', 'Selected_Category')->name('Selected_Category');
        Route::get('/medicineInfo', 'Display_Medicine_info')->name('Display_Medicine_info');
        Route::post('/search', 'Search_Not_Expired')->name('Search_Not_Expired');

    });
});



Route::prefix('/admin')->group(function () {
    Route::controller(AdminController::class)->group(function () {
        Route::post('/login', 'login')->name('login');
        Route::post('/new_medicine', 'Add_Medicine');
        Route::delete('/delete_medicine', 'Delete_Medicine');
        Route::post('/categories', 'Add_Categories');
    });
    Route::controller(MedicinesController::class)->group(function () {
        Route::middleware('auth:sanctum')->get('/medicines', 'ShowAll')->name('ShowAll');
        Route::get('/categoryFilter', 'Selected_Category')->name('Selected_Category');
        Route::get('/medicineInfo', 'Display_Medicine_info')->name('Display_Medicine_info');
        Route::post('/search', 'Search_All')->name('Search_All');
    });
});

