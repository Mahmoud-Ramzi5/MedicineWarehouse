<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;
    protected $guarded = [
        "en_Category_name",
        "ar_Category_name",
        "en_Description",
        "ar_Description"
    ];

    protected $hidden = [
        "created_at",
        "updated_at",
        "en_Description",
        "ar_Description",
    ];
    // ManyToMany Relation
    public function Medicines()
    {
        return $this->belongsToMany(Medicine::class, 'medicine_category', 'category_id', 'medicine_id');
    }
}
