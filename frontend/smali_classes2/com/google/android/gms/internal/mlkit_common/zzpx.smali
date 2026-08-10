.class public final synthetic Lcom/google/android/gms/internal/mlkit_common/zzpx;
.super Ljava/lang/Object;
.source "com.google.mlkit:common@@18.9.0"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic zza:Lcom/google/android/gms/internal/mlkit_common/zzpz;

.field public final synthetic zzb:Lcom/google/android/gms/internal/mlkit_common/zzpq;

.field public final synthetic zzc:Lcom/google/android/gms/internal/mlkit_common/zzln;

.field public final synthetic zzd:Ljava/lang/String;


# direct methods
.method public synthetic constructor <init>(Lcom/google/android/gms/internal/mlkit_common/zzpz;Lcom/google/android/gms/internal/mlkit_common/zzpq;Lcom/google/android/gms/internal/mlkit_common/zzln;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzpx;->zza:Lcom/google/android/gms/internal/mlkit_common/zzpz;

    iput-object p2, p0, Lcom/google/android/gms/internal/mlkit_common/zzpx;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzpq;

    iput-object p3, p0, Lcom/google/android/gms/internal/mlkit_common/zzpx;->zzc:Lcom/google/android/gms/internal/mlkit_common/zzln;

    iput-object p4, p0, Lcom/google/android/gms/internal/mlkit_common/zzpx;->zzd:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzpx;->zza:Lcom/google/android/gms/internal/mlkit_common/zzpz;

    iget-object v1, p0, Lcom/google/android/gms/internal/mlkit_common/zzpx;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzpq;

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_common/zzpx;->zzc:Lcom/google/android/gms/internal/mlkit_common/zzln;

    iget-object v3, p0, Lcom/google/android/gms/internal/mlkit_common/zzpx;->zzd:Ljava/lang/String;

    invoke-virtual {v0, v1, v2, v3}, Lcom/google/android/gms/internal/mlkit_common/zzpz;->zzb(Lcom/google/android/gms/internal/mlkit_common/zzpq;Lcom/google/android/gms/internal/mlkit_common/zzln;Ljava/lang/String;)V

    return-void
.end method
