<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;
    protected $guarded = [
        "En_Category_name",
        "Ar_Category_name",
        "En_Description",
        "Ar_Description"
    ];
    // ManyToMany Relation
    public function Medicines()
    {
        return $this->belongsToMany(Medicine::class, 'medicine_category', 'category_id', 'medicine_id');
    }
}
