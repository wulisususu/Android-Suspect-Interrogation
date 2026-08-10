.class public final enum Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;
.super Ljava/lang/Enum;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"


# static fields
.field public static final enum zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

.field public static final enum zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

.field public static final enum zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

.field private static final synthetic zzd:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

    const-string v1, "DEFAULT"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

    new-instance v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

    const-string v2, "SIGNED"

    const/4 v3, 0x1

    .line 2
    invoke-direct {v1, v2, v3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

    new-instance v2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

    const-string v3, "FIXED"

    const/4 v4, 0x2

    .line 3
    invoke-direct {v2, v3, v4}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;-><init>(Ljava/lang/String;I)V

    sput-object v2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

    filled-new-array {v0, v1, v2}, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;->zzd:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static values()[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;->zzd:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

    .line 1
    invoke-virtual {v0}, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

    return-object v0
.end method
