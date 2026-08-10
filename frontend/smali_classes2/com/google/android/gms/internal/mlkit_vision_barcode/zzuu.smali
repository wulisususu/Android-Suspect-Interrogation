.class public abstract Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;
.super Ljava/lang/Object;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"


# static fields
.field public static final zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;

.field public static final zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    invoke-static {}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zzm()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;->zzm()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;

    .line 2
    invoke-static {}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zzm()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;->zzi(Z)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    .line 3
    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;->zzm()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static zzm()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;
    .locals 5

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzul;

    invoke-direct {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzul;-><init>()V

    const/16 v1, 0xa

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzul;->zzg(I)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    const/4 v1, 0x5

    .line 2
    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;->zze(I)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    const/high16 v1, 0x3e800000    # 0.25f

    .line 3
    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;->zzf(F)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    const v1, 0x3f4ccccd    # 0.8f

    .line 4
    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;->zzd(F)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    const/4 v2, 0x1

    .line 5
    invoke-virtual {v0, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;->zzi(Z)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    const/high16 v3, 0x3f000000    # 0.5f

    .line 6
    invoke-virtual {v0, v3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;->zzc(F)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    .line 7
    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;->zzb(F)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    const-wide/16 v3, 0x5dc

    .line 8
    invoke-virtual {v0, v3, v4}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;->zzk(J)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    const-wide/16 v3, 0xbb8

    .line 9
    invoke-virtual {v0, v3, v4}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;->zzh(J)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    .line 10
    invoke-virtual {v0, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;->zza(Z)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    const v1, 0x3dcccccd    # 0.1f

    .line 11
    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;->zzj(F)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    const v1, 0x3d4ccccd    # 0.05f

    .line 12
    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;->zzl(F)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzut;

    return-object v0
.end method


# virtual methods
.method abstract zza()F
.end method

.method abstract zzb()F
.end method

.method abstract zzc()F
.end method

.method abstract zzd()F
.end method

.method abstract zze()F
.end method

.method abstract zzf()F
.end method

.method abstract zzg()I
.end method

.method abstract zzh()I
.end method

.method abstract zzi()J
.end method

.method abstract zzj()J
.end method

.method abstract zzk()Z
.end method

.method abstract zzl()Z
.end method
