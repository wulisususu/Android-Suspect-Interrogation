.class public final Lio/ionic/starter/AliyunPushApp;
.super Landroid/app/Application;
.source "AliyunPushApp.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0002\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010\u0003\u001a\u00020\u0004H\u0002J\u0008\u0010\u0005\u001a\u00020\u0004H\u0016\u00a8\u0006\u0006"
    }
    d2 = {
        "Lio/ionic/starter/AliyunPushApp;",
        "Landroid/app/Application;",
        "()V",
        "initThirdPush",
        "",
        "onCreate",
        "app_uatRelease"
    }
    k = 0x1
    mv = {
        0x1,
        0x9,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method

.method private final initThirdPush()V
    .locals 0

    return-void
.end method


# virtual methods
.method public onCreate()V
    .locals 8

    .line 26
    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    .line 27
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    invoke-static {v0}, Lcom/alibaba/sdk/android/push/noonesdk/PushServiceFactory;->init(Landroid/content/Context;)V

    const-string v1, "AliyunPush"

    const-string v2, "Aliyun Push begin ccccccccccccccccccccccccccc"

    .line 29
    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v1, "notification"

    .line 34
    invoke-virtual {p0, v1}, Lio/ionic/starter/AliyunPushApp;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    const-string v2, "null cannot be cast to non-null type android.app.NotificationManager"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v1, Landroid/app/NotificationManager;

    .line 35
    new-instance v2, Landroid/app/NotificationChannelGroup;

    const-string v3, "aliyunChannelGroup"

    check-cast v3, Ljava/lang/CharSequence;

    const-string v4, "aliyunGroup"

    invoke-direct {v2, v4, v3}, Landroid/app/NotificationChannelGroup;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;)V

    .line 36
    invoke-virtual {v1, v2}, Landroid/app/NotificationManager;->createNotificationChannelGroup(Landroid/app/NotificationChannelGroup;)V

    .line 38
    new-instance v2, Landroid/app/NotificationChannel;

    const-string v3, "default push channel"

    .line 40
    check-cast v3, Ljava/lang/CharSequence;

    const/4 v5, 0x4

    const-string v6, "default_channel"

    .line 38
    invoke-direct {v2, v6, v3, v5}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    const-string v3, "Aliyun Notification Description"

    .line 43
    invoke-virtual {v2, v3}, Landroid/app/NotificationChannel;->setDescription(Ljava/lang/String;)V

    const/4 v3, 0x1

    .line 44
    invoke-virtual {v2, v3}, Landroid/app/NotificationChannel;->enableLights(Z)V

    const/high16 v5, -0x10000

    .line 45
    invoke-virtual {v2, v5}, Landroid/app/NotificationChannel;->setLightColor(I)V

    .line 46
    invoke-virtual {v2, v3}, Landroid/app/NotificationChannel;->enableVibration(Z)V

    const/16 v3, 0x9

    new-array v3, v3, [J

    fill-array-data v3, :array_0

    .line 47
    invoke-virtual {v2, v3}, Landroid/app/NotificationChannel;->setVibrationPattern([J)V

    .line 49
    invoke-virtual {p0}, Lio/ionic/starter/AliyunPushApp;->getPackageName()Ljava/lang/String;

    move-result-object v3

    sget v5, Lio/ionic/starter/R$raw;->alicloud_notification_sound:I

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "android.resource://"

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "/"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    .line 50
    sget-object v5, Landroid/app/Notification;->AUDIO_ATTRIBUTES_DEFAULT:Landroid/media/AudioAttributes;

    .line 48
    invoke-virtual {v2, v3, v5}, Landroid/app/NotificationChannel;->setSound(Landroid/net/Uri;Landroid/media/AudioAttributes;)V

    .line 52
    invoke-virtual {v2, v4}, Landroid/app/NotificationChannel;->setGroup(Ljava/lang/String;)V

    .line 53
    invoke-virtual {v1, v2}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    .line 56
    invoke-static {}, Lcom/alibaba/sdk/android/push/noonesdk/PushServiceFactory;->getPushControlService()Lcom/alibaba/sdk/android/push/PushControlService;

    move-result-object v1

    new-instance v2, Lio/ionic/starter/AliyunPushApp$onCreate$1;

    invoke-direct {v2}, Lio/ionic/starter/AliyunPushApp$onCreate$1;-><init>()V

    check-cast v2, Lcom/alibaba/sdk/android/push/PushControlService$ConnectionChangeListener;

    invoke-interface {v1, v2}, Lcom/alibaba/sdk/android/push/PushControlService;->setConnectionChangeListener(Lcom/alibaba/sdk/android/push/PushControlService$ConnectionChangeListener;)V

    .line 69
    invoke-static {}, Lcom/alibaba/sdk/android/push/noonesdk/PushServiceFactory;->getCloudPushService()Lcom/alibaba/sdk/android/push/CloudPushService;

    move-result-object v1

    new-instance v2, Lio/ionic/starter/AliyunPushApp$onCreate$2;

    invoke-direct {v2}, Lio/ionic/starter/AliyunPushApp$onCreate$2;-><init>()V

    check-cast v2, Lcom/alibaba/sdk/android/push/CommonCallback;

    invoke-interface {v1, v0, v2}, Lcom/alibaba/sdk/android/push/CloudPushService;->register(Landroid/content/Context;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    .line 85
    invoke-direct {p0}, Lio/ionic/starter/AliyunPushApp;->initThirdPush()V

    return-void

    :array_0
    .array-data 8
        0x64
        0xc8
        0x12c
        0x190
        0x1f4
        0x190
        0x12c
        0xc8
        0x190
    .end array-data
.end method
