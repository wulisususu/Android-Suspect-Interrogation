.class public final Lcom/google/android/gms/internal/mlkit_common/zzkk;
.super Ljava/lang/Object;
.source "com.google.mlkit:common@@18.9.0"


# instance fields
.field private final zza:Lcom/google/android/gms/internal/mlkit_common/zzlw;

.field private final zzb:Ljava/lang/Boolean;


# direct methods
.method synthetic constructor <init>(Lcom/google/android/gms/internal/mlkit_common/zzki;Lcom/google/android/gms/internal/mlkit_common/zzkj;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {p1}, Lcom/google/android/gms/internal/mlkit_common/zzki;->zzd(Lcom/google/android/gms/internal/mlkit_common/zzki;)Lcom/google/android/gms/internal/mlkit_common/zzlw;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/internal/mlkit_common/zzkk;->zza:Lcom/google/android/gms/internal/mlkit_common/zzlw;

    invoke-static {p1}, Lcom/google/android/gms/internal/mlkit_common/zzki;->zze(Lcom/google/android/gms/internal/mlkit_common/zzki;)Ljava/lang/Boolean;

    move-result-object p1

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzkk;->zzb:Ljava/lang/Boolean;

    return-void
.end method


# virtual methods
.method public final zza()Lcom/google/android/gms/internal/mlkit_common/zzlw;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzkk;->zza:Lcom/google/android/gms/internal/mlkit_common/zzlw;

    return-object v0
.end method

.method public final zzb()Ljava/lang/Boolean;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzkk;->zzb:Ljava/lang/Boolean;

    return-object v0
.end method
