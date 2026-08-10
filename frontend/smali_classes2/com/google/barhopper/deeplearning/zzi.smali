.class public final Lcom/google/barhopper/deeplearning/zzi;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;
.source "com.google.mlkit:barcode-scanning@@17.2.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfp;


# static fields
.field private static final zza:Lcom/google/barhopper/deeplearning/zzi;


# instance fields
.field private zzd:I

.field private zze:Ljava/lang/String;

.field private zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;

.field private zzg:I

.field private zzh:F

.field private zzi:F

.field private zzj:Lcom/google/barhopper/deeplearning/zzf;

.field private zzk:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzei;

.field private zzl:I

.field private zzm:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzht;

.field private zzn:I

.field private zzo:I

.field private zzp:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/google/barhopper/deeplearning/zzi;

    invoke-direct {v0}, Lcom/google/barhopper/deeplearning/zzi;-><init>()V

    sput-object v0, Lcom/google/barhopper/deeplearning/zzi;->zza:Lcom/google/barhopper/deeplearning/zzi;

    const-class v1, Lcom/google/barhopper/deeplearning/zzi;

    .line 2
    invoke-static {v1, v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;->zzU(Ljava/lang/Class;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;)V

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/google/barhopper/deeplearning/zzi;->zze:Ljava/lang/String;

    .line 2
    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;

    iput-object v0, p0, Lcom/google/barhopper/deeplearning/zzi;->zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;

    const/16 v0, 0xa

    iput v0, p0, Lcom/google/barhopper/deeplearning/zzi;->zzg:I

    const/high16 v0, 0x3f000000    # 0.5f

    iput v0, p0, Lcom/google/barhopper/deeplearning/zzi;->zzh:F

    const v0, 0x3d4ccccd    # 0.05f

    iput v0, p0, Lcom/google/barhopper/deeplearning/zzi;->zzi:F

    .line 3
    invoke-static {}, Lcom/google/barhopper/deeplearning/zzi;->zzL()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzei;

    move-result-object v0

    iput-object v0, p0, Lcom/google/barhopper/deeplearning/zzi;->zzk:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzei;

    const/4 v0, 0x1

    iput v0, p0, Lcom/google/barhopper/deeplearning/zzi;->zzl:I

    const/16 v0, 0x140

    iput v0, p0, Lcom/google/barhopper/deeplearning/zzi;->zzn:I

    const/4 v0, 0x4

    iput v0, p0, Lcom/google/barhopper/deeplearning/zzi;->zzo:I

    const/4 v0, 0x2

    iput v0, p0, Lcom/google/barhopper/deeplearning/zzi;->zzp:I

    return-void
.end method

.method public static zza()Lcom/google/barhopper/deeplearning/zzh;
    .locals 1

    sget-object v0, Lcom/google/barhopper/deeplearning/zzi;->zza:Lcom/google/barhopper/deeplearning/zzi;

    .line 1
    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;->zzF()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdx;

    move-result-object v0

    check-cast v0, Lcom/google/barhopper/deeplearning/zzh;

    return-object v0
.end method

.method static synthetic zzb()Lcom/google/barhopper/deeplearning/zzi;
    .locals 1

    sget-object v0, Lcom/google/barhopper/deeplearning/zzi;->zza:Lcom/google/barhopper/deeplearning/zzi;

    return-object v0
.end method

.method static synthetic zzc(Lcom/google/barhopper/deeplearning/zzi;Lcom/google/barhopper/deeplearning/zzf;)V
    .locals 0

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    iput-object p1, p0, Lcom/google/barhopper/deeplearning/zzi;->zzj:Lcom/google/barhopper/deeplearning/zzf;

    iget p1, p0, Lcom/google/barhopper/deeplearning/zzi;->zzd:I

    or-int/lit8 p1, p1, 0x20

    iput p1, p0, Lcom/google/barhopper/deeplearning/zzi;->zzd:I

    return-void
.end method

.method static synthetic zzd(Lcom/google/barhopper/deeplearning/zzi;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;)V
    .locals 1

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    iget v0, p0, Lcom/google/barhopper/deeplearning/zzi;->zzd:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/google/barhopper/deeplearning/zzi;->zzd:I

    iput-object p1, p0, Lcom/google/barhopper/deeplearning/zzi;->zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;

    return-void
.end method


# virtual methods
.method protected final zzg(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 14

    add-int/lit8 v0, p1, -0x1

    if-eqz v0, :cond_4

    const/4 v1, 0x2

    if-eq v0, v1, :cond_3

    const/4 v1, 0x3

    if-eq v0, v1, :cond_2

    const/4 v1, 0x4

    const/4 v2, 0x0

    if-eq v0, v1, :cond_1

    const/4 v1, 0x5

    if-eq v0, v1, :cond_0

    return-object v2

    :cond_0
    sget-object v0, Lcom/google/barhopper/deeplearning/zzi;->zza:Lcom/google/barhopper/deeplearning/zzi;

    return-object v0

    .line 1
    :cond_1
    new-instance v0, Lcom/google/barhopper/deeplearning/zzh;

    .line 3
    invoke-direct {v0, v2}, Lcom/google/barhopper/deeplearning/zzh;-><init>(Lcom/google/barhopper/deeplearning/zzg;)V

    return-object v0

    :cond_2
    new-instance v0, Lcom/google/barhopper/deeplearning/zzi;

    .line 4
    invoke-direct {v0}, Lcom/google/barhopper/deeplearning/zzi;-><init>()V

    return-object v0

    :cond_3
    const-string/jumbo v1, "zzd"

    const-string/jumbo v2, "zze"

    const-string/jumbo v3, "zzf"

    const-string/jumbo v4, "zzg"

    const-string/jumbo v5, "zzh"

    const-string/jumbo v6, "zzi"

    const-string/jumbo v7, "zzj"

    const-string/jumbo v8, "zzk"

    const-string/jumbo v9, "zzl"

    const-string/jumbo v10, "zzm"

    const-string/jumbo v11, "zzn"

    const-string/jumbo v12, "zzo"

    const-string/jumbo v13, "zzp"

    .line 2
    filled-new-array/range {v1 .. v13}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v1, Lcom/google/barhopper/deeplearning/zzi;->zza:Lcom/google/barhopper/deeplearning/zzi;

    const-string v2, "\u0001\u000c\u0000\u0001\u0001\u000c\u000c\u0000\u0001\u0000\u0001\u1008\u0000\u0002\u100a\u0001\u0003\u100b\u0002\u0004\u1001\u0003\u0005\u1001\u0004\u0006\u1009\u0005\u0007\u0013\u0008\u1004\u0006\t\u1009\u0007\n\u1004\u0008\u000b\u1004\t\u000c\u1004\n"

    invoke-static {v1, v2, v0}, Lcom/google/barhopper/deeplearning/zzi;->zzR(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfo;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :cond_4
    const/4 v0, 0x1

    .line 1
    invoke-static {v0}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v0

    return-object v0
.end method
