.class public Lcom/alibaba/sdk/android/push/common/global/MpsGlobalSetter;
.super Ljava/lang/Object;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized setDebug(Z)V
    .locals 1

    const-class v0, Lcom/alibaba/sdk/android/push/common/global/MpsGlobalSetter;

    monitor-enter v0

    :try_start_0
    sput-boolean p0, Lcom/alibaba/sdk/android/push/common/global/b;->g:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static declared-synchronized setMessageIntentService(Ljava/lang/Class;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)V"
        }
    .end annotation

    const-class v0, Lcom/alibaba/sdk/android/push/common/global/MpsGlobalSetter;

    monitor-enter v0

    if-eqz p0, :cond_0

    :try_start_0
    sput-object p0, Lcom/alibaba/sdk/android/push/common/global/b;->c:Ljava/lang/Class;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0

    :cond_0
    :goto_0
    monitor-exit v0

    return-void
.end method

.method public static declared-synchronized setNotificationId(I)V
    .locals 1

    const-class v0, Lcom/alibaba/sdk/android/push/common/global/MpsGlobalSetter;

    monitor-enter v0

    :try_start_0
    sput p0, Lcom/alibaba/sdk/android/push/common/global/b;->f:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static declared-synchronized setNotificationIntentRequestCode(I)V
    .locals 1

    const-class v0, Lcom/alibaba/sdk/android/push/common/global/MpsGlobalSetter;

    monitor-enter v0

    :try_start_0
    sput p0, Lcom/alibaba/sdk/android/push/common/global/b;->e:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static declared-synchronized setNotificationLargeIconBitmap(Landroid/graphics/Bitmap;)V
    .locals 1

    const-class v0, Lcom/alibaba/sdk/android/push/common/global/MpsGlobalSetter;

    monitor-enter v0

    :try_start_0
    sput-object p0, Lcom/alibaba/sdk/android/push/common/global/b;->b:Landroid/graphics/Bitmap;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static declared-synchronized setNotificationSmallIconId(I)V
    .locals 1

    const-class v0, Lcom/alibaba/sdk/android/push/common/global/MpsGlobalSetter;

    monitor-enter v0

    :try_start_0
    sput p0, Lcom/alibaba/sdk/android/push/common/global/b;->d:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static declared-synchronized setNotificationSoundPath(Ljava/lang/String;)V
    .locals 2

    const-class v0, Lcom/alibaba/sdk/android/push/common/global/MpsGlobalSetter;

    monitor-enter v0

    if-eqz p0, :cond_0

    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    sput-object p0, Lcom/alibaba/sdk/android/push/common/global/b;->a:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0

    :cond_0
    :goto_0
    monitor-exit v0

    return-void
.end method
