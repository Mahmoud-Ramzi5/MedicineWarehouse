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
        "Commercial_name",
        "Scientific_name",
        "Manufacture_company",
    ];

    // OneToMany Relation
    public function Medicine()
    {
        return $this->belongsTo(Medicine::class, "medicine_id");
    }
}
