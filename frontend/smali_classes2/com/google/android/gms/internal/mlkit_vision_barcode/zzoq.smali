.class public final enum Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;
.super Ljava/lang/Enum;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfe;


# static fields
.field public static final enum zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

.field public static final enum zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

.field public static final enum zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

.field public static final enum zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

.field public static final enum zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

.field public static final enum zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

.field public static final enum zzg:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

.field public static final enum zzh:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

.field public static final enum zzi:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

.field public static final enum zzj:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

.field private static final synthetic zzk:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;


# instance fields
.field private final zzl:I


# direct methods
.method static constructor <clinit>()V
    .locals 13

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    const-string v1, "UNKNOWN_FORMAT"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    new-instance v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    const-string v2, "NV16"

    const/4 v3, 0x1

    .line 2
    invoke-direct {v1, v2, v3, v3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;-><init>(Ljava/lang/String;II)V

    sput-object v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    new-instance v2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    const-string v3, "NV21"

    const/4 v4, 0x2

    .line 3
    invoke-direct {v2, v3, v4, v4}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;-><init>(Ljava/lang/String;II)V

    sput-object v2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    new-instance v3, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    const-string v4, "YV12"

    const/4 v5, 0x3

    .line 4
    invoke-direct {v3, v4, v5, v5}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;-><init>(Ljava/lang/String;II)V

    sput-object v3, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    new-instance v4, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    const-string v5, "YUV_420_888"

    const/4 v6, 0x4

    const/4 v7, 0x7

    .line 5
    invoke-direct {v4, v5, v6, v7}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;-><init>(Ljava/lang/String;II)V

    sput-object v4, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    new-instance v5, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    const-string v8, "JPEG"

    const/4 v9, 0x5

    const/16 v10, 0x8

    .line 6
    invoke-direct {v5, v8, v9, v10}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;-><init>(Ljava/lang/String;II)V

    sput-object v5, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    new-instance v8, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    const-string v11, "BITMAP"

    const/4 v12, 0x6

    .line 7
    invoke-direct {v8, v11, v12, v6}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;-><init>(Ljava/lang/String;II)V

    sput-object v8, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzg:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    new-instance v11, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    const-string v6, "CM_SAMPLE_BUFFER_REF"

    .line 8
    invoke-direct {v11, v6, v7, v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;-><init>(Ljava/lang/String;II)V

    sput-object v11, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzh:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    new-instance v9, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    const-string v6, "UI_IMAGE"

    .line 9
    invoke-direct {v9, v6, v10, v12}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;-><init>(Ljava/lang/String;II)V

    sput-object v9, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzi:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    new-instance v10, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    const-string v6, "CV_PIXEL_BUFFER_REF"

    const/16 v7, 0x9

    .line 10
    invoke-direct {v10, v6, v7, v7}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;-><init>(Ljava/lang/String;II)V

    sput-object v10, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzj:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    move-object v6, v8

    move-object v7, v11

    move-object v8, v9

    move-object v9, v10

    filled-new-array/range {v0 .. v9}, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzk:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzl:I

    return-void
.end method

.method public static values()[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzk:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    .line 1
    invoke-virtual {v0}, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    return-object v0
.end method


# virtual methods
.method public final zza()I
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzl:I

    return v0
.end method
