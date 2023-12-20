<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'user_id',
        'status',
        'is_paid'
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

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'is_paid' => 'boolean',
    ];

    // OneToMany Relation
    public function User()
    {
        return $this->belongsTo(User::class, "user_id");
    }

    // OneToMany Relation
    public function OrderedMedicines()
    {
        return $this->hasMany(OrderedMedicine::class, "order_id");
    }

    // ManyToMany Relation
    public function Medicines()
    {
        return $this->belongsToMany(Medicine::class, 'order_medicine', 'order_id', 'medicine_id');
    }
}
