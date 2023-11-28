<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;
    protected $guarded = [
        "en_category_name",
        "ar_category_name",
        "en_description",
        "ar_description"
    ];
    // ManyToMany Relation
    public function Medicines()
    {
        return $this->belongsToMany(Medicine::class, 'medicine_category', 'category_id', 'medicine_id');
    }
}
