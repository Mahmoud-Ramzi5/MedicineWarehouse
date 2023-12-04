<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MedicineTranslation extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        "medicine_id",
        "lang",
        "commercial_name",
        "scientific_name",
        "manufacture_company",
        "description"
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'created_at',
        'updated_at',
    ];

    // OneToMany Relation
    public function Medicine()
    {
        return $this->belongsTo(Medicine::class, "medicine_id");
    }
}
