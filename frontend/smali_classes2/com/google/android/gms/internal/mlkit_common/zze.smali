.class final Lcom/google/android/gms/internal/mlkit_common/zze;
.super Lcom/google/android/gms/internal/mlkit_common/zzs;
.source "com.google.mlkit:common@@18.9.0"


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/google/android/gms/internal/mlkit_common/zzs;-><init>()V

    return-void
.end method


# virtual methods
.method protected final zza(Landroid/content/Context;Lcom/google/android/gms/internal/mlkit_common/zzr;Z)I
    .locals 0

    .line 1
    iget-object p2, p2, Lcom/google/android/gms/internal/mlkit_common/zzr;->zza:Landroid/net/Uri;

    invoke-virtual {p2}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object p2

    const/16 p3, 0x40

    invoke-virtual {p2, p3}, Ljava/lang/String;->lastIndexOf(I)I

    move-result p2

    if-ltz p2, :cond_0

    const-string p2, "android.permission.INTERACT_ACROSS_USERS"

    .line 2
    invoke-static {p1, p2}, Landroidx/core/content/PermissionChecker;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result p1

    if-nez p1, :cond_0

    const/4 p1, 0x2

    return p1

    :cond_0
    const/4 p1, 0x3

    return p1
.end method
