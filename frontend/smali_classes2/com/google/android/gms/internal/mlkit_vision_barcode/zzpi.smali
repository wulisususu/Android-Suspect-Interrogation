.class public final enum Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;
.super Ljava/lang/Enum;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfe;


# static fields
.field public static final enum zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

.field public static final enum zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

.field public static final enum zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

.field public static final enum zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

.field private static final synthetic zze:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;


# instance fields
.field private final zzf:I


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    const-string v1, "TYPE_UNKNOWN"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    new-instance v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    const-string v2, "TYPE_THIN"

    const/4 v3, 0x1

    .line 2
    invoke-direct {v1, v2, v3, v3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;-><init>(Ljava/lang/String;II)V

    sput-object v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    new-instance v2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    const-string v3, "TYPE_THICK"

    const/4 v4, 0x2

    .line 3
    invoke-direct {v2, v3, v4, v4}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;-><init>(Ljava/lang/String;II)V

    sput-object v2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    new-instance v3, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    const-string v4, "TYPE_GMV"

    const/4 v5, 0x3

    .line 4
    invoke-direct {v3, v4, v5, v5}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;-><init>(Ljava/lang/String;II)V

    sput-object v3, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    filled-new-array {v0, v1, v2, v3}, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zze:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zzf:I

    return-void
.end method

.method public static values()[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zze:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    .line 1
    invoke-virtual {v0}, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    return-object v0
.end method


# virtual methods
.method public final zza()I
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zzf:I

    return v0
.end method
