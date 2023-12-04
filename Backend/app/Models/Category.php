<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    /**
     * The attributes that are not mass assignable.
     *
     * @var array<int, string>
     */
    protected $guarded = [
        "en_Category_name",
        "ar_Category_name",
        "en_Description",
        "ar_Description"
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        "en_description",
        "ar_description",
        'created_at',
        'updated_at',
    ];

    // ManyToMany Relation
    public function Medicines()
    {
        return $this->belongsToMany(Medicine::class, 'medicine_category', 'category_id', 'medicine_id');
    }
}
