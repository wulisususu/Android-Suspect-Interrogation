.class public final Lcom/google/photos/vision/barhopper/zzc;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;
.source "com.google.mlkit:barcode-scanning@@17.2.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfp;


# static fields
.field private static final zza:Lcom/google/photos/vision/barhopper/zzc;


# instance fields
.field private zzd:I

.field private zze:I

.field private zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;

.field private zzg:Ljava/lang/String;

.field private zzh:I

.field private zzi:Lcom/google/photos/vision/barhopper/zzr;

.field private zzj:Lcom/google/photos/vision/barhopper/zzy;

.field private zzk:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzci;

.field private zzl:Lcom/google/photos/vision/barhopper/zzag;

.field private zzm:Lcom/google/photos/vision/barhopper/zzao;

.field private zzn:Lcom/google/photos/vision/barhopper/zzaj;

.field private zzo:Lcom/google/photos/vision/barhopper/zzac;

.field private zzp:Lcom/google/photos/vision/barhopper/zzp;

.field private zzq:Lcom/google/photos/vision/barhopper/zzt;

.field private zzr:Lcom/google/photos/vision/barhopper/zzl;

.field private zzs:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;

.field private zzt:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzej;

.field private zzu:Ljava/lang/String;

.field private zzv:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;

.field private zzw:Z

.field private zzx:D

.field private zzy:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;

.field private zzz:B


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/google/photos/vision/barhopper/zzc;

    invoke-direct {v0}, Lcom/google/photos/vision/barhopper/zzc;-><init>()V

    sput-object v0, Lcom/google/photos/vision/barhopper/zzc;->zza:Lcom/google/photos/vision/barhopper/zzc;

    const-class v1, Lcom/google/photos/vision/barhopper/zzc;

    .line 2
    invoke-static {v1, v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;->zzU(Ljava/lang/Class;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;)V

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;-><init>()V

    const/4 v0, 0x2

    iput-byte v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzz:B

    .line 2
    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;

    iput-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;

    const-string v0, ""

    iput-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzg:Ljava/lang/String;

    .line 3
    invoke-static {}, Lcom/google/photos/vision/barhopper/zzc;->zzO()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;

    move-result-object v1

    iput-object v1, p0, Lcom/google/photos/vision/barhopper/zzc;->zzs:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;

    .line 4
    invoke-static {}, Lcom/google/photos/vision/barhopper/zzc;->zzN()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzej;

    move-result-object v1

    iput-object v1, p0, Lcom/google/photos/vision/barhopper/zzc;->zzt:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzej;

    iput-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzu:Ljava/lang/String;

    .line 5
    invoke-static {}, Lcom/google/photos/vision/barhopper/zzc;->zzO()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;

    move-result-object v0

    iput-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzv:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzw:Z

    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;

    iput-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzy:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;

    return-void
.end method

.method static synthetic zzc()Lcom/google/photos/vision/barhopper/zzc;
    .locals 1

    sget-object v0, Lcom/google/photos/vision/barhopper/zzc;->zza:Lcom/google/photos/vision/barhopper/zzc;

    return-object v0
.end method

.method static synthetic zzp(Lcom/google/photos/vision/barhopper/zzc;ILcom/google/photos/vision/barhopper/zzae;)V
    .locals 2

    .line 1
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzs:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;

    .line 2
    invoke-interface {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;->zzc()Z

    move-result v1

    if-nez v1, :cond_0

    .line 3
    invoke-static {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;->zzP(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;)Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;

    move-result-object v0

    iput-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzs:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;

    :cond_0
    iget-object p0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzs:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;

    .line 4
    invoke-interface {p0, p1, p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public final zzA()I
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzh:I

    invoke-static {v0}, Lcom/google/photos/vision/barhopper/zzi;->zza(I)I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method public final zza()I
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzs:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;

    .line 1
    invoke-interface {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;->size()I

    move-result v0

    return v0
.end method

.method public final zzb()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzci;
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzk:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzci;

    if-nez v0, :cond_0

    .line 1
    invoke-static {}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzci;->zzb()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzci;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public final zzd()Lcom/google/photos/vision/barhopper/zzp;
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzp:Lcom/google/photos/vision/barhopper/zzp;

    if-nez v0, :cond_0

    .line 1
    invoke-static {}, Lcom/google/photos/vision/barhopper/zzp;->zzd()Lcom/google/photos/vision/barhopper/zzp;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public final zze()Lcom/google/photos/vision/barhopper/zzr;
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzi:Lcom/google/photos/vision/barhopper/zzr;

    if-nez v0, :cond_0

    .line 1
    invoke-static {}, Lcom/google/photos/vision/barhopper/zzr;->zzc()Lcom/google/photos/vision/barhopper/zzr;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public final zzf()Lcom/google/photos/vision/barhopper/zzt;
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzq:Lcom/google/photos/vision/barhopper/zzt;

    if-nez v0, :cond_0

    .line 1
    invoke-static {}, Lcom/google/photos/vision/barhopper/zzt;->zzb()Lcom/google/photos/vision/barhopper/zzt;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method protected final zzg(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 28

    move-object/from16 v0, p0

    add-int/lit8 v1, p1, -0x1

    if-eqz v1, :cond_5

    const/4 v2, 0x2

    if-eq v1, v2, :cond_4

    const/4 v2, 0x3

    if-eq v1, v2, :cond_3

    const/4 v2, 0x4

    const/4 v3, 0x0

    if-eq v1, v2, :cond_2

    const/4 v2, 0x5

    if-eq v1, v2, :cond_1

    if-nez p2, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    const/4 v1, 0x1

    :goto_0
    iput-byte v1, v0, Lcom/google/photos/vision/barhopper/zzc;->zzz:B

    return-object v3

    :cond_1
    sget-object v1, Lcom/google/photos/vision/barhopper/zzc;->zza:Lcom/google/photos/vision/barhopper/zzc;

    return-object v1

    .line 1
    :cond_2
    new-instance v1, Lcom/google/photos/vision/barhopper/zzb;

    .line 3
    invoke-direct {v1, v3}, Lcom/google/photos/vision/barhopper/zzb;-><init>(Lcom/google/photos/vision/barhopper/zza;)V

    return-object v1

    :cond_3
    new-instance v1, Lcom/google/photos/vision/barhopper/zzc;

    .line 4
    invoke-direct {v1}, Lcom/google/photos/vision/barhopper/zzc;-><init>()V

    return-object v1

    :cond_4
    const-string/jumbo v2, "zzd"

    const-string/jumbo v3, "zze"

    .line 2
    sget-object v4, Lcom/google/photos/vision/barhopper/zze;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;

    const-string/jumbo v5, "zzf"

    const-string/jumbo v6, "zzg"

    const-string/jumbo v7, "zzh"

    sget-object v8, Lcom/google/photos/vision/barhopper/zzh;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;

    const-string/jumbo v9, "zzi"

    const-string/jumbo v10, "zzj"

    const-string/jumbo v11, "zzk"

    const-string/jumbo v12, "zzl"

    const-string/jumbo v13, "zzm"

    const-string/jumbo v14, "zzn"

    const-string/jumbo v15, "zzs"

    const-class v16, Lcom/google/photos/vision/barhopper/zzae;

    const-string/jumbo v17, "zzu"

    const-string/jumbo v18, "zzv"

    const-class v19, Lcom/google/photos/vision/barhopper/zzae;

    const-string/jumbo v20, "zzy"

    const-string/jumbo v21, "zzo"

    const-string/jumbo v22, "zzp"

    const-string/jumbo v23, "zzq"

    const-string/jumbo v24, "zzt"

    const-string/jumbo v25, "zzr"

    const-string/jumbo v26, "zzw"

    const-string/jumbo v27, "zzx"

    filled-new-array/range {v2 .. v27}, [Ljava/lang/Object;

    move-result-object v1

    sget-object v2, Lcom/google/photos/vision/barhopper/zzc;->zza:Lcom/google/photos/vision/barhopper/zzc;

    const-string v3, "\u0001\u0015\u0000\u0001\u0001\u0015\u0015\u0000\u0003\u000b\u0001\u1d0c\u0000\u0002\u150a\u0001\u0003\u1508\u0002\u0004\u1d0c\u0003\u0005\u1409\u0004\u0006\u1009\u0005\u0007\u1009\u0006\u0008\u1409\u0007\t\u1409\u0008\n\u1409\t\u000b\u041b\u000c\u1008\u000e\r\u041b\u000e\u100a\u0011\u000f\u1409\n\u0010\u1009\u000b\u0011\u1009\u000c\u0012\u0016\u0013\u1009\r\u0014\u1007\u000f\u0015\u1000\u0010"

    invoke-static {v2, v3, v1}, Lcom/google/photos/vision/barhopper/zzc;->zzR(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfo;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    return-object v1

    :cond_5
    iget-byte v1, v0, Lcom/google/photos/vision/barhopper/zzc;->zzz:B

    .line 1
    invoke-static {v1}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v1

    return-object v1
.end method

.method public final zzh()Lcom/google/photos/vision/barhopper/zzy;
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzj:Lcom/google/photos/vision/barhopper/zzy;

    if-nez v0, :cond_0

    .line 1
    invoke-static {}, Lcom/google/photos/vision/barhopper/zzy;->zzb()Lcom/google/photos/vision/barhopper/zzy;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public final zzi()Lcom/google/photos/vision/barhopper/zzac;
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzo:Lcom/google/photos/vision/barhopper/zzac;

    if-nez v0, :cond_0

    .line 1
    invoke-static {}, Lcom/google/photos/vision/barhopper/zzac;->zzd()Lcom/google/photos/vision/barhopper/zzac;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public final zzj()Lcom/google/photos/vision/barhopper/zzag;
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzl:Lcom/google/photos/vision/barhopper/zzag;

    if-nez v0, :cond_0

    .line 1
    invoke-static {}, Lcom/google/photos/vision/barhopper/zzag;->zzb()Lcom/google/photos/vision/barhopper/zzag;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public final zzk()Lcom/google/photos/vision/barhopper/zzaj;
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzn:Lcom/google/photos/vision/barhopper/zzaj;

    if-nez v0, :cond_0

    .line 1
    invoke-static {}, Lcom/google/photos/vision/barhopper/zzaj;->zzb()Lcom/google/photos/vision/barhopper/zzaj;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public final zzl()Lcom/google/photos/vision/barhopper/zzao;
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzm:Lcom/google/photos/vision/barhopper/zzao;

    if-nez v0, :cond_0

    .line 1
    invoke-static {}, Lcom/google/photos/vision/barhopper/zzao;->zzb()Lcom/google/photos/vision/barhopper/zzao;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public final zzm()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdb;

    return-object v0
.end method

.method public final zzn()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzg:Ljava/lang/String;

    return-object v0
.end method

.method public final zzo()Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzs:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;

    return-object v0
.end method

.method public final zzq()Z
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzd:I

    and-int/lit16 v0, v0, 0x800

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public final zzr()Z
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzd:I

    and-int/lit8 v0, v0, 0x10

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public final zzs()Z
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzd:I

    and-int/lit16 v0, v0, 0x1000

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public final zzt()Z
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzd:I

    and-int/lit8 v0, v0, 0x20

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public final zzu()Z
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzd:I

    and-int/lit16 v0, v0, 0x400

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public final zzv()Z
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzd:I

    and-int/lit8 v0, v0, 0x40

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public final zzw()Z
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzd:I

    and-int/lit16 v0, v0, 0x80

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public final zzx()Z
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzd:I

    and-int/lit16 v0, v0, 0x200

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public final zzy()Z
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zzd:I

    and-int/lit16 v0, v0, 0x100

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public final zzz()I
    .locals 1

    iget v0, p0, Lcom/google/photos/vision/barhopper/zzc;->zze:I

    invoke-static {v0}, Lcom/google/photos/vision/barhopper/zzf;->zza(I)I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method
