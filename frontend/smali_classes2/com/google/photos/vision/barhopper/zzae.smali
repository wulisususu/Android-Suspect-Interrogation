.class public final Lcom/google/photos/vision/barhopper/zzae;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;
.source "com.google.mlkit:barcode-scanning@@17.2.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfp;


# static fields
.field private static final zza:Lcom/google/photos/vision/barhopper/zzae;


# instance fields
.field private zzd:I

.field private zze:I

.field private zzf:I

.field private zzg:B


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/google/photos/vision/barhopper/zzae;

    invoke-direct {v0}, Lcom/google/photos/vision/barhopper/zzae;-><init>()V

    sput-object v0, Lcom/google/photos/vision/barhopper/zzae;->zza:Lcom/google/photos/vision/barhopper/zzae;

    const-class v1, Lcom/google/photos/vision/barhopper/zzae;

    invoke-static {v1, v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;->zzU(Ljava/lang/Class;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;)V

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;-><init>()V

    const/4 v0, 0x2

    iput-byte v0, p0, Lcom/google/photos/vision/barhopper/zzae;->zzg:B

    return-void
.end method

.method public static zzc()Lcom/google/photos/vision/barhopper/zzad;
    .locals 1

    sget-object v0, Lcom/google/photos/vision/barhopper/zzae;->zza:Lcom/google/photos/vision/barhopper/zzae;

    .line 1
    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;->zzF()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdx;

    move-result-object v0

    check-cast v0, Lcom/google/photos/vision/barhopper/zzad;

    return-object v0
.end method

.method static synthetic zzd()Lcom/google/photos/vision/barhopper/zzae;
    .locals 1

    sget-object v0, Lcom/google/photos/vision/barhopper/zzae;->zza:Lcom/google/photos/vision/barhopper/zzae;

    return-object v0
.end method

.method static synthetic zze(Lcom/google/photos/vision/barhopper/zzae;I)V
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzae;->zzd:I

    or-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/google/photos/vision/barhopper/zzae;->zzd:I

    iput p1, p0, Lcom/google/photos/vision/barhopper/zzae;->zze:I

    return-void
.end method

.method static synthetic zzf(Lcom/google/photos/vision/barhopper/zzae;I)V
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzae;->zzd:I

    or-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/google/photos/vision/barhopper/zzae;->zzd:I

    iput p1, p0, Lcom/google/photos/vision/barhopper/zzae;->zzf:I

    return-void
.end method


# virtual methods
.method public final zza()I
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzae;->zze:I

    return v0
.end method

.method public final zzb()I
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzae;->zzf:I

    return v0
.end method

.method protected final zzg(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    add-int/lit8 p1, p1, -0x1

    if-eqz p1, :cond_5

    const/4 p3, 0x2

    if-eq p1, p3, :cond_4

    const/4 p3, 0x3

    if-eq p1, p3, :cond_3

    const/4 p3, 0x4

    const/4 v0, 0x0

    if-eq p1, p3, :cond_2

    const/4 p3, 0x5

    if-eq p1, p3, :cond_1

    if-nez p2, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/4 p1, 0x1

    :goto_0
    iput-byte p1, p0, Lcom/google/photos/vision/barhopper/zzae;->zzg:B

    return-object v0

    :cond_1
    sget-object p1, Lcom/google/photos/vision/barhopper/zzae;->zza:Lcom/google/photos/vision/barhopper/zzae;

    return-object p1

    .line 1
    :cond_2
    new-instance p1, Lcom/google/photos/vision/barhopper/zzad;

    .line 3
    invoke-direct {p1, v0}, Lcom/google/photos/vision/barhopper/zzad;-><init>(Lcom/google/photos/vision/barhopper/zza;)V

    return-object p1

    :cond_3
    new-instance p1, Lcom/google/photos/vision/barhopper/zzae;

    invoke-direct {p1}, Lcom/google/photos/vision/barhopper/zzae;-><init>()V

    return-object p1

    :cond_4
    const-string/jumbo p1, "zze"

    const-string/jumbo p2, "zzf"

    const-string/jumbo p3, "zzd"

    .line 2
    filled-new-array {p3, p1, p2}, [Ljava/lang/Object;

    move-result-object p1

    sget-object p2, Lcom/google/photos/vision/barhopper/zzae;->zza:Lcom/google/photos/vision/barhopper/zzae;

    const-string p3, "\u0001\u0002\u0000\u0001\u0001\u0002\u0002\u0000\u0000\u0002\u0001\u1504\u0000\u0002\u1504\u0001"

    invoke-static {p2, p3, p1}, Lcom/google/photos/vision/barhopper/zzae;->zzR(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfo;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1

    :cond_5
    iget-byte p1, p0, Lcom/google/photos/vision/barhopper/zzae;->zzg:B

    .line 1
    invoke-static {p1}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object p1

    return-object p1
.end method
