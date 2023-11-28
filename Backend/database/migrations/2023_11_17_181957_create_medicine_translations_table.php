<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('medicine_translations', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("medicine_id")->unsigned();
            $table->string("lang");
            $table->string("commercial_name");
            $table->string("scientific_name");
            $table->string("manufacture_company");
            $table->string("description")->nullable();
            $table->timestamps();

            $table->foreign('medicine_id')->references('id')->on('medicines')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('medicine_translations');
    }
};
