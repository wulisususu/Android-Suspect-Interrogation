.class public Lcom/alibaba/sdk/android/push/notification/d;
.super Ljava/lang/Object;


# static fields
.field static a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "MPS:MessageNotification"

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->getLogger(Ljava/lang/String;)Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;)Landroid/net/Uri;
    .locals 5

    sget-object v0, Landroid/net/Uri;->EMPTY:Landroid/net/Uri;

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    const-string v2, "android.resource://"

    if-nez v1, :cond_2

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->a()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p2, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    :goto_0
    move-object v0, p1

    goto/16 :goto_2

    :cond_0
    const-string v0, "/raw/"

    invoke-virtual {p2, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    goto :goto_1

    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    :goto_1
    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/alibaba/sdk/android/push/common/global/b;->a()Ljava/lang/String;

    move-result-object p2

    if-eqz p2, :cond_3

    invoke-static {}, Lcom/alibaba/sdk/android/push/common/global/b;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    goto :goto_2

    :cond_3
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    const-string v1, "raw"

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    const-string v4, "alicloud_notification_sound"

    invoke-virtual {p2, v4, v1, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p2

    sget-object v1, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "sound resId:"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    if-eqz p2, :cond_4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "/"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    sget-object p1, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v1, "  ;uri:"

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    :cond_4
    :goto_2
    sget-object p1, Landroid/net/Uri;->EMPTY:Landroid/net/Uri;

    if-ne v0, p1, :cond_5

    const/4 p1, 0x2

    invoke-static {p1}, Landroid/media/RingtoneManager;->getDefaultUri(I)Landroid/net/Uri;

    move-result-object v0

    :cond_5
    sget-object p1, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    new-instance p2, Ljava/lang/StringBuilder;

    const-string v1, "soundUri:"

    invoke-direct {p2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    return-object v0
.end method

.method private a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Landroid/app/Notification;)V
    .locals 6

    const/4 v0, 0x6

    new-array v0, v0, [J

    fill-array-data v0, :array_0

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->d()I

    move-result v1

    const/4 v2, 0x1

    if-eq v1, v2, :cond_8

    const/4 v2, 0x2

    if-eq v1, v2, :cond_1

    const/4 v3, 0x3

    if-eq v1, v3, :cond_0

    goto/16 :goto_4

    :cond_0
    iput-object v0, p3, Landroid/app/Notification;->vibrate:[J

    :cond_1
    sget-object v0, Landroid/net/Uri;->EMPTY:Landroid/net/Uri;

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    const-string v3, "android.resource://"

    if-nez v1, :cond_4

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->a()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {p2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    :goto_0
    move-object v0, p1

    goto :goto_3

    :cond_2
    const-string v0, "/raw/"

    invoke-virtual {p2, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    goto :goto_1

    :cond_3
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    :goto_1
    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    goto :goto_0

    :cond_4
    invoke-static {}, Lcom/alibaba/sdk/android/push/common/global/b;->a()Ljava/lang/String;

    move-result-object p2

    if-eqz p2, :cond_5

    invoke-static {}, Lcom/alibaba/sdk/android/push/common/global/b;->a()Ljava/lang/String;

    move-result-object p1

    :goto_2
    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    goto :goto_3

    :cond_5
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    const-string v1, "raw"

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    const-string v5, "alicloud_notification_sound"

    invoke-virtual {p2, v5, v1, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p2

    if-eqz p2, :cond_6

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "/"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_2

    :cond_6
    :goto_3
    sget-object p1, Landroid/net/Uri;->EMPTY:Landroid/net/Uri;

    if-ne v0, p1, :cond_7

    invoke-static {v2}, Landroid/media/RingtoneManager;->getDefaultUri(I)Landroid/net/Uri;

    move-result-object v0

    :cond_7
    iput-object v0, p3, Landroid/app/Notification;->sound:Landroid/net/Uri;

    goto :goto_4

    :cond_8
    iput-object v0, p3, Landroid/app/Notification;->vibrate:[J

    :goto_4
    return-void

    :array_0
    .array-data 8
        0x64
        0xfa
        0x64
        0xfa
        0x64
        0xfa
    .end array-data
.end method

.method public static a(Ljava/util/Map;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)Z"
        }
    .end annotation

    const-string v0, "custom_notification_id"

    invoke-interface {p0, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;

    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0

    if-eqz p0, :cond_0

    invoke-static {}, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->getInstance()Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a(I)Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;

    move-result-object p0

    if-eqz p0, :cond_0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;->isBuildWhenAppInForeground()Z

    move-result p0

    return p0

    :cond_0
    const/4 p0, 0x1

    return p0
.end method

.method private b(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Landroid/app/Notification;)V
    .locals 3

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v1, "custom notification feedback"

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    const/4 v0, 0x6

    new-array v0, v0, [J

    fill-array-data v0, :array_0

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->i()I

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    :cond_0
    const/4 v1, 0x2

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->i()I

    move-result v2

    if-ne v1, v2, :cond_1

    invoke-direct {p0, p1, p2}, Lcom/alibaba/sdk/android/push/notification/d;->a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;)Landroid/net/Uri;

    move-result-object p1

    iput-object p1, p3, Landroid/app/Notification;->sound:Landroid/net/Uri;

    goto :goto_1

    :cond_1
    const/4 v1, 0x1

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->i()I

    move-result v2

    if-ne v1, v2, :cond_2

    :goto_0
    iput-object v0, p3, Landroid/app/Notification;->vibrate:[J

    goto :goto_1

    :cond_2
    const/4 v1, 0x3

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->i()I

    move-result v2

    if-ne v1, v2, :cond_3

    invoke-direct {p0, p1, p2}, Lcom/alibaba/sdk/android/push/notification/d;->a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;)Landroid/net/Uri;

    move-result-object p1

    iput-object p1, p3, Landroid/app/Notification;->sound:Landroid/net/Uri;

    goto :goto_0

    :cond_3
    const/4 p1, -0x1

    iput p1, p3, Landroid/app/Notification;->defaults:I

    :goto_1
    return-void

    :array_0
    .array-data 8
        0x64
        0xfa
        0x64
        0xfa
        0x64
        0xfa
    .end array-data
.end method


# virtual methods
.method public a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Lcom/alibaba/sdk/android/push/notification/PushData;Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;)Landroid/app/Notification;
    .locals 5

    :try_start_0
    new-instance v0, Lcom/alibaba/sdk/android/push/notification/a;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/push/notification/a;-><init>()V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->a(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->b(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->p()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->a(I)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->q()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->c(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->r()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->d(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->s()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->b(I)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->t()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->e(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->u()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->f(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->v()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->g(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->w()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->h(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->i(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->x()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->x()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->j(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->y()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->k(Ljava/lang/String;)V

    :cond_1
    :goto_0
    invoke-virtual {v0, p1, p3, p4}, Lcom/alibaba/sdk/android/push/notification/c;->b(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/PushData;Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;)Landroid/app/Notification;

    move-result-object v0

    if-nez v0, :cond_2

    new-instance v0, Landroid/app/Notification;

    const-string v1, ""

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    const v4, 0x1080077

    invoke-direct {v0, v4, v1, v2, v3}, Landroid/app/Notification;-><init>(ILjava/lang/CharSequence;J)V

    :cond_2
    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->g()I

    move-result v1

    const/4 v2, 0x1

    if-eq v2, v1, :cond_3

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->o()Z

    move-result v1

    if-nez v1, :cond_3

    sget-object v1, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v2, "custom notification option first"

    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    invoke-direct {p0, p1, p2, v0}, Lcom/alibaba/sdk/android/push/notification/d;->b(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Landroid/app/Notification;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->h()I

    move-result p1

    iput p1, v0, Landroid/app/Notification;->flags:I

    goto :goto_1

    :cond_3
    invoke-direct {p0, p1, p2, v0}, Lcom/alibaba/sdk/android/push/notification/d;->a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Landroid/app/Notification;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->e()Z

    move-result p1

    if-nez p1, :cond_4

    iget p1, v0, Landroid/app/Notification;->flags:I

    or-int/lit8 p1, p1, 0x10

    iput p1, v0, Landroid/app/Notification;->flags:I

    goto :goto_1

    :cond_4
    iget p1, v0, Landroid/app/Notification;->flags:I

    or-int/lit8 p1, p1, 0x20

    iput p1, v0, Landroid/app/Notification;->flags:I

    :goto_1
    if-eqz p4, :cond_5

    invoke-interface {p4, v0, p3}, Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;->configNotification(Landroid/app/Notification;Lcom/alibaba/sdk/android/push/notification/PushData;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_5
    return-object v0

    :catchall_0
    move-exception p1

    sget-object p2, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string p3, "onNotification createSummaryNotification error"

    invoke-virtual {p2, p3, p1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Landroid/content/Context;Ljava/util/Map;)Lcom/alibaba/sdk/android/push/notification/b;
    .locals 17
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/alibaba/sdk/android/push/notification/b;"
        }
    .end annotation

    move-object/from16 v1, p2

    const-string v0, "_ALIYUN_NOTIFICATION_PRIORITY_"

    const-string v2, "title"

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    const-string v4, "content"

    invoke-interface {v1, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v3}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_9

    invoke-static {v4}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    goto/16 :goto_5

    :cond_0
    new-instance v5, Lcom/alibaba/sdk/android/push/notification/b;

    invoke-direct {v5}, Lcom/alibaba/sdk/android/push/notification/b;-><init>()V

    const-string v7, "remind"

    invoke-interface {v1, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-static {v7}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v8

    const/4 v9, 0x3

    if-eqz v8, :cond_1

    invoke-static {v9}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v7

    :cond_1
    const-string v8, "music"

    invoke-interface {v1, v8}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    const-string v10, "ext"

    invoke-interface {v1, v10}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    const-string v11, "notification_channel"

    invoke-interface {v1, v11}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;

    const-string v12, "style"

    invoke-interface {v1, v12}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/String;

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    const-string v13, "big_body"

    invoke-interface {v1, v13}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    const-string v14, "big_picture"

    invoke-interface {v1, v14}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/String;

    const-string v15, "inbox_content"

    invoke-interface {v1, v15}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/String;

    const-string v6, "tid"

    invoke-interface {v1, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    const-string v9, "emas_group"

    invoke-interface {v1, v9}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    move-object/from16 v16, v0

    const-string v0, "ctg"

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v5, v3}, Lcom/alibaba/sdk/android/push/notification/b;->b(Ljava/lang/String;)V

    invoke-virtual {v5, v4}, Lcom/alibaba/sdk/android/push/notification/b;->d(Ljava/lang/String;)V

    invoke-virtual {v5, v4}, Lcom/alibaba/sdk/android/push/notification/b;->c(Ljava/lang/String;)V

    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v5, v3}, Lcom/alibaba/sdk/android/push/notification/b;->a(I)V

    invoke-virtual {v5, v11}, Lcom/alibaba/sdk/android/push/notification/b;->f(Ljava/lang/String;)V

    const-string v3, "image"

    invoke-interface {v1, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v5, v3}, Lcom/alibaba/sdk/android/push/notification/b;->g(Ljava/lang/String;)V

    invoke-virtual {v5, v6}, Lcom/alibaba/sdk/android/push/notification/b;->l(Ljava/lang/String;)V

    invoke-virtual {v5, v9}, Lcom/alibaba/sdk/android/push/notification/b;->m(Ljava/lang/String;)V

    invoke-virtual {v5, v0}, Lcom/alibaba/sdk/android/push/notification/b;->n(Ljava/lang/String;)V

    invoke-static {v12}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    :try_start_0
    invoke-static {v12}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v5, v0}, Lcom/alibaba/sdk/android/push/notification/b;->k(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    :cond_2
    invoke-virtual {v5, v2}, Lcom/alibaba/sdk/android/push/notification/b;->h(Ljava/lang/String;)V

    invoke-virtual {v5, v13}, Lcom/alibaba/sdk/android/push/notification/b;->i(Ljava/lang/String;)V

    invoke-virtual {v5, v14}, Lcom/alibaba/sdk/android/push/notification/b;->j(Ljava/lang/String;)V

    invoke-virtual {v5, v15}, Lcom/alibaba/sdk/android/push/notification/b;->k(Ljava/lang/String;)V

    invoke-static {v8}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    const/4 v6, 0x0

    goto :goto_0

    :cond_3
    move-object v6, v8

    :goto_0
    invoke-virtual {v5, v6}, Lcom/alibaba/sdk/android/push/notification/b;->a(Ljava/lang/String;)V

    invoke-static {v10}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_5

    :try_start_1
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, v10}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/alibaba/sdk/android/push/common/util/JSONUtils;->toMap(Lorg/json/JSONObject;)Ljava/util/Map;

    move-result-object v0

    move-object/from16 v2, v16

    invoke-interface {v0, v2}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    :goto_1
    invoke-virtual {v5, v2}, Lcom/alibaba/sdk/android/push/notification/b;->e(Ljava/lang/String;)V

    goto :goto_2

    :cond_4
    const/4 v2, 0x0

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    goto :goto_1

    :goto_2
    invoke-virtual {v5, v0}, Lcom/alibaba/sdk/android/push/notification/b;->a(Ljava/util/Map;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_3

    :catch_0
    move-exception v0

    sget-object v2, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v3, "Parse inner json(ext) error:"

    invoke-virtual {v2, v3, v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_5
    :goto_3
    const-string v0, "custom_notification_id"

    invoke-interface {v1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_8

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_7

    invoke-static {}, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->getInstance()Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a(I)Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;

    move-result-object v0

    if-nez v0, :cond_6

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v1, "custom notification is null"

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->w(Ljava/lang/String;)V

    goto :goto_4

    :cond_6
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;->getNotificationType()I

    move-result v1

    invoke-virtual {v5, v1}, Lcom/alibaba/sdk/android/push/notification/b;->c(I)V

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;->getStatusBarDrawable()I

    move-result v1

    invoke-virtual {v5, v1}, Lcom/alibaba/sdk/android/push/notification/b;->b(I)V

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;->getRemindType()I

    move-result v1

    invoke-virtual {v5, v1}, Lcom/alibaba/sdk/android/push/notification/b;->e(I)V

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;->getNotificationFlags()I

    move-result v1

    invoke-virtual {v5, v1}, Lcom/alibaba/sdk/android/push/notification/b;->d(I)V

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;->isServerOptionFirst()Z

    move-result v1

    invoke-virtual {v5, v1}, Lcom/alibaba/sdk/android/push/notification/b;->a(Z)V

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;->getNotificationType()I

    move-result v1

    const/4 v2, 0x3

    if-ne v2, v1, :cond_8

    check-cast v0, Lcom/alibaba/sdk/android/push/notification/AdvancedCustomPushNotification;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/notification/AdvancedCustomPushNotification;->getContentView()I

    move-result v1

    invoke-virtual {v5, v1}, Lcom/alibaba/sdk/android/push/notification/b;->i(I)V

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/notification/AdvancedCustomPushNotification;->getNotificationView()I

    move-result v1

    invoke-virtual {v5, v1}, Lcom/alibaba/sdk/android/push/notification/b;->f(I)V

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/notification/AdvancedCustomPushNotification;->getTitleView()I

    move-result v1

    invoke-virtual {v5, v1}, Lcom/alibaba/sdk/android/push/notification/b;->h(I)V

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/notification/AdvancedCustomPushNotification;->getIconView()I

    move-result v1

    invoke-virtual {v5, v1}, Lcom/alibaba/sdk/android/push/notification/b;->g(I)V

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/notification/AdvancedCustomPushNotification;->getIcon()I

    move-result v0

    invoke-virtual {v5, v0}, Lcom/alibaba/sdk/android/push/notification/b;->j(I)V

    goto :goto_4

    :cond_7
    sget-object v0, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v1, "default notification"

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    :cond_8
    :goto_4
    return-object v5

    :cond_9
    :goto_5
    sget-object v0, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "title or content of notify is empty: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;)V

    const/4 v0, 0x0

    return-object v0
.end method

.method public b(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Lcom/alibaba/sdk/android/push/notification/PushData;Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;)Landroid/app/Notification;
    .locals 6

    :try_start_0
    new-instance v0, Lcom/alibaba/sdk/android/push/notification/a;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/push/notification/a;-><init>()V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->x()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->y()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Lcom/alibaba/sdk/android/push/notification/c;->a(Ljava/lang/String;)V

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->x()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->j(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->c()Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->b(Ljava/lang/String;)V

    goto :goto_1

    :cond_0
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->y()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->k(Ljava/lang/String;)V

    :cond_1
    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->c()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :goto_1
    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->p()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->a(I)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->q()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->c(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->r()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->d(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->s()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->b(I)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->t()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->e(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->u()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->f(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->v()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->g(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->w()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->h(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->i(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->z()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/notification/c;->l(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->g()I

    move-result v1

    const/4 v2, 0x1

    if-eq v2, v1, :cond_2

    sget-object v1, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v3, "building customNotification"

    invoke-virtual {v1, v3}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->getInstance()Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2, p3, p4}, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Lcom/alibaba/sdk/android/push/notification/PushData;Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;)Landroid/app/Notification;

    move-result-object v1

    if-nez v1, :cond_3

    sget-object v1, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v3, "build custom notification failed, build default notification"

    invoke-virtual {v1, v3}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;)V

    :cond_2
    invoke-virtual {v0, p1, p3, p4}, Lcom/alibaba/sdk/android/push/notification/c;->a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/PushData;Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;)Landroid/app/Notification;

    move-result-object v1

    :cond_3
    if-nez v1, :cond_4

    new-instance v1, Landroid/app/Notification;

    const-string v0, ""

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    const v5, 0x1080077

    invoke-direct {v1, v5, v0, v3, v4}, Landroid/app/Notification;-><init>(ILjava/lang/CharSequence;J)V

    :cond_4
    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->g()I

    move-result v0

    if-eq v2, v0, :cond_5

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->o()Z

    move-result v0

    if-nez v0, :cond_5

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v2, "custom notification option first"

    invoke-virtual {v0, v2}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    invoke-direct {p0, p1, p2, v1}, Lcom/alibaba/sdk/android/push/notification/d;->b(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Landroid/app/Notification;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->h()I

    move-result p1

    iput p1, v1, Landroid/app/Notification;->flags:I

    goto :goto_2

    :cond_5
    invoke-direct {p0, p1, p2, v1}, Lcom/alibaba/sdk/android/push/notification/d;->a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Landroid/app/Notification;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->e()Z

    move-result p1

    if-nez p1, :cond_6

    iget p1, v1, Landroid/app/Notification;->flags:I

    or-int/lit8 p1, p1, 0x10

    iput p1, v1, Landroid/app/Notification;->flags:I

    goto :goto_2

    :cond_6
    iget p1, v1, Landroid/app/Notification;->flags:I

    or-int/lit8 p1, p1, 0x20

    iput p1, v1, Landroid/app/Notification;->flags:I

    :goto_2
    if-eqz p4, :cond_7

    invoke-interface {p4, v1, p3}, Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;->configNotification(Landroid/app/Notification;Lcom/alibaba/sdk/android/push/notification/PushData;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_7
    return-object v1

    :catchall_0
    move-exception p1

    sget-object p2, Lcom/alibaba/sdk/android/push/notification/d;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string p3, "onNotification"

    invoke-virtual {p2, p3, p1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    const/4 p1, 0x0

    return-object p1
.end method
