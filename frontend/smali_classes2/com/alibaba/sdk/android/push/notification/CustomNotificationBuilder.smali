.class public Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;
.super Ljava/lang/Object;


# static fields
.field public static final NOTIFICATION_ICON_RES_TYPE:Ljava/lang/String; = "drawable"

.field public static final NOTIFICATION_LARGE_ICON_FILE:Ljava/lang/String; = "alicloud_notification_largeicon"

.field public static final NOTIFICATION_SMALL_ICON_FILE:Ljava/lang/String; = "alicloud_notification_smallicon"

.field static a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

.field private static c:Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;


# instance fields
.field private b:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "MPS:CustomNotificationBuilder"

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->getLogger(Ljava/lang/String;)Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const/4 v0, 0x0

    sput-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->c:Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b:Ljava/util/Map;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b:Ljava/util/Map;

    return-void
.end method

.method private a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;)I
    .locals 3

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->f()I

    move-result p2

    if-eqz p2, :cond_0

    return p2

    :cond_0
    invoke-static {}, Lcom/alibaba/sdk/android/push/common/global/b;->c()I

    move-result p2

    if-eqz p2, :cond_1

    invoke-static {}, Lcom/alibaba/sdk/android/push/common/global/b;->c()I

    move-result p2

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    const-string v0, "drawable"

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "alicloud_notification_smallicon"

    invoke-virtual {p2, v2, v0, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p2

    :goto_0
    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object p1

    iget-object p1, p1, Landroid/content/pm/PackageInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget p1, p1, Landroid/content/pm/ApplicationInfo;->icon:I
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v1, "Get system icon error, package name not found, "

    invoke-virtual {v0, v1, p1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    const p1, 0x1080077

    :goto_1
    if-nez p2, :cond_2

    move p2, p1

    :cond_2
    return p2
.end method

.method private a(Landroid/graphics/drawable/Drawable;)Landroid/graphics/Bitmap;
    .locals 5

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v0

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v1

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getOpacity()I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_0

    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    goto :goto_0

    :cond_0
    sget-object v2, Landroid/graphics/Bitmap$Config;->RGB_565:Landroid/graphics/Bitmap$Config;

    :goto_0
    invoke-static {v0, v1, v2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    new-instance v1, Landroid/graphics/Canvas;

    invoke-direct {v1, v0}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v2

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v3

    const/4 v4, 0x0

    invoke-virtual {p1, v4, v4, v2, v3}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    invoke-virtual {p1, v1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    return-object v0
.end method

.method private b(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Lcom/alibaba/sdk/android/push/notification/PushData;Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;)Landroid/app/Notification;
    .locals 16

    move-object/from16 v1, p1

    move-object/from16 v2, p4

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v3, "building basic custom notification"

    invoke-virtual {v0, v3}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->s()I

    move-result v0

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->t()Ljava/lang/String;

    move-result-object v3

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->u()Ljava/lang/String;

    move-result-object v4

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->w()Ljava/lang/String;

    move-result-object v5

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->a()Ljava/lang/String;

    move-result-object v6

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->v()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    const/4 v8, 0x0

    if-nez v7, :cond_0

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->v()Ljava/lang/String;

    move-result-object v7

    const-string v9, "big_picture"

    invoke-static {v1, v7, v9}, Lcom/alibaba/sdk/android/push/util/DownloadUtil;->downloadImage(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v7

    goto :goto_0

    :cond_0
    move-object v7, v8

    :goto_0
    invoke-direct/range {p0 .. p2}, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;)Landroid/graphics/Bitmap;

    move-result-object v9

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->x()Ljava/lang/String;

    move-result-object v10

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->y()Ljava/lang/String;

    move-result-object v11

    new-instance v12, Landroid/app/Notification$Builder;

    invoke-direct {v12, v1}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->b()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v13

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->c()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v13

    invoke-direct/range {p0 .. p2}, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;)I

    move-result v14

    invoke-virtual {v13, v14}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v13

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->p()I

    move-result v14

    invoke-virtual {v13, v14}, Landroid/app/Notification$Builder;->setPriority(I)Landroid/app/Notification$Builder;

    move-result-object v13

    const-string v14, ""

    invoke-virtual {v13, v14}, Landroid/app/Notification$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v13

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v14

    invoke-virtual {v13, v14, v15}, Landroid/app/Notification$Builder;->setWhen(J)Landroid/app/Notification$Builder;

    if-eqz v9, :cond_1

    invoke-virtual {v12, v9}, Landroid/app/Notification$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/app/Notification$Builder;

    :cond_1
    invoke-static {v10}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v13

    if-nez v13, :cond_2

    invoke-virtual {v12, v10}, Landroid/app/Notification$Builder;->setGroup(Ljava/lang/String;)Landroid/app/Notification$Builder;

    goto :goto_1

    :cond_2
    invoke-static {v11}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v10

    if-nez v10, :cond_3

    invoke-virtual {v12, v11}, Landroid/app/Notification$Builder;->setGroup(Ljava/lang/String;)Landroid/app/Notification$Builder;

    :cond_3
    :goto_1
    const/4 v10, 0x0

    const/4 v11, 0x1

    if-ne v0, v11, :cond_5

    new-instance v0, Landroid/app/Notification$BigTextStyle;

    invoke-direct {v0}, Landroid/app/Notification$BigTextStyle;-><init>()V

    invoke-virtual {v0, v4}, Landroid/app/Notification$BigTextStyle;->bigText(Ljava/lang/CharSequence;)Landroid/app/Notification$BigTextStyle;

    move-result-object v0

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_4

    invoke-virtual {v0, v3}, Landroid/app/Notification$BigTextStyle;->setBigContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$BigTextStyle;

    :cond_4
    :goto_2
    invoke-virtual {v12, v0}, Landroid/app/Notification$Builder;->setStyle(Landroid/app/Notification$Style;)Landroid/app/Notification$Builder;

    goto :goto_4

    :cond_5
    const/4 v4, 0x2

    if-ne v0, v4, :cond_7

    new-instance v0, Landroid/app/Notification$BigPictureStyle;

    invoke-direct {v0}, Landroid/app/Notification$BigPictureStyle;-><init>()V

    invoke-virtual {v0, v7}, Landroid/app/Notification$BigPictureStyle;->bigPicture(Landroid/graphics/Bitmap;)Landroid/app/Notification$BigPictureStyle;

    move-result-object v0

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_6

    invoke-virtual {v0, v3}, Landroid/app/Notification$BigPictureStyle;->setBigContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$BigPictureStyle;

    :cond_6
    if-eqz v9, :cond_4

    invoke-virtual {v0, v9}, Landroid/app/Notification$BigPictureStyle;->bigLargeIcon(Landroid/graphics/Bitmap;)Landroid/app/Notification$BigPictureStyle;

    goto :goto_2

    :cond_7
    const/4 v4, 0x3

    if-ne v0, v4, :cond_a

    new-instance v4, Landroid/app/Notification$InboxStyle;

    invoke-direct {v4}, Landroid/app/Notification$InboxStyle;-><init>()V

    :try_start_0
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0, v5}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    move v5, v10

    :goto_3
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v7

    if-ge v5, v7, :cond_8

    invoke-virtual {v0, v5}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v7}, Landroid/app/Notification$InboxStyle;->addLine(Ljava/lang/CharSequence;)Landroid/app/Notification$InboxStyle;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v5, v5, 0x1

    goto :goto_3

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    :cond_8
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_9

    invoke-virtual {v4, v3}, Landroid/app/Notification$InboxStyle;->setBigContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$InboxStyle;

    :cond_9
    invoke-virtual {v12, v4}, Landroid/app/Notification$Builder;->setStyle(Landroid/app/Notification$Style;)Landroid/app/Notification$Builder;

    :cond_a
    :goto_4
    invoke-virtual {v12, v11}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->q()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_b

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->q()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v12, v0}, Landroid/app/Notification$Builder;->setChannelId(Ljava/lang/String;)Landroid/app/Notification$Builder;

    :cond_b
    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_e

    const-string v0, "android.resource://"

    invoke-virtual {v6, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_c

    invoke-static {v6}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    :goto_5
    invoke-virtual {v12, v0}, Landroid/app/Notification$Builder;->setSound(Landroid/net/Uri;)Landroid/app/Notification$Builder;

    goto :goto_7

    :cond_c
    const-string v3, "/raw/"

    invoke-virtual {v6, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_d

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    goto :goto_6

    :cond_d
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    :goto_6
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    goto :goto_5

    :cond_e
    :goto_7
    if-eqz v2, :cond_f

    move-object/from16 v1, p3

    invoke-interface {v2, v12, v1}, Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;->configBuilder(Landroid/app/Notification$Builder;Lcom/alibaba/sdk/android/push/notification/PushData;)V

    :cond_f
    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->z()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_11

    invoke-virtual/range {p2 .. p2}, Lcom/alibaba/sdk/android/push/notification/b;->z()Ljava/lang/String;

    move-result-object v0

    const-class v1, Landroid/app/Notification;

    invoke-virtual {v1}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v1

    array-length v2, v1

    :goto_8
    if-ge v10, v2, :cond_11

    aget-object v3, v1, v10

    invoke-virtual {v3}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_10

    :try_start_1
    invoke-virtual {v3, v8}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v12, v3}, Landroid/app/Notification$Builder;->setCategory(Ljava/lang/String;)Landroid/app/Notification$Builder;
    :try_end_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_9

    :catch_1
    sget-object v3, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "set category error: "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;)V

    :cond_10
    :goto_9
    add-int/lit8 v10, v10, 0x1

    goto :goto_8

    :cond_11
    invoke-virtual {v12}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    return-object v0
.end method

.method private b(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;)Landroid/graphics/Bitmap;
    .locals 4

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->r()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->r()Ljava/lang/String;

    move-result-object p2

    const-string v0, "image"

    invoke-static {p1, p2, v0}, Lcom/alibaba/sdk/android/push/util/DownloadUtil;->downloadImage(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object p2

    goto :goto_0

    :cond_0
    const/4 p2, 0x0

    :goto_0
    if-nez p2, :cond_2

    invoke-static {}, Lcom/alibaba/sdk/android/push/common/global/b;->b()Landroid/graphics/Bitmap;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-static {}, Lcom/alibaba/sdk/android/push/common/global/b;->b()Landroid/graphics/Bitmap;

    move-result-object p2

    goto :goto_1

    :cond_1
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "drawable"

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "alicloud_notification_largeicon"

    invoke-virtual {v0, v3, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a(Landroid/graphics/drawable/Drawable;)Landroid/graphics/Bitmap;

    move-result-object p2

    :cond_2
    :goto_1
    return-object p2
.end method

.method private c(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Lcom/alibaba/sdk/android/push/notification/PushData;Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;)Landroid/app/Notification;
    .locals 8

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->a()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v2, "building advanced custom notification"

    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->j()I

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_a

    new-instance v1, Landroid/widget/RemoteViews;

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->j()I

    move-result v4

    invoke-direct {v1, v3, v4}, Landroid/widget/RemoteViews;-><init>(Ljava/lang/String;I)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->l()I

    move-result v3

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->b()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->m()I

    move-result v3

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->c()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->n()I

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->k()I

    move-result v3

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->n()I

    move-result v4

    goto :goto_0

    :cond_0
    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->k()I

    move-result v3

    const v4, 0x1080077

    :goto_0
    invoke-virtual {v1, v3, v4}, Landroid/widget/RemoteViews;->setImageViewResource(II)V

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->x()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->y()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Landroid/app/Notification$Builder;

    invoke-direct {v5, p1}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {v5, v1}, Landroid/app/Notification$Builder;->setContent(Landroid/widget/RemoteViews;)Landroid/app/Notification$Builder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->p()I

    move-result v6

    invoke-virtual {v1, v6}, Landroid/app/Notification$Builder;->setPriority(I)Landroid/app/Notification$Builder;

    move-result-object v1

    invoke-direct {p0, p1, p2}, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;)I

    move-result v6

    invoke-virtual {v1, v6}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v1

    const-string v6, ""

    invoke-virtual {v1, v6}, Landroid/app/Notification$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-virtual {v1, v6, v7}, Landroid/app/Notification$Builder;->setWhen(J)Landroid/app/Notification$Builder;

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {v5, v3}, Landroid/app/Notification$Builder;->setGroup(Ljava/lang/String;)Landroid/app/Notification$Builder;

    goto :goto_1

    :cond_1
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_2

    invoke-virtual {v5, v4}, Landroid/app/Notification$Builder;->setGroup(Ljava/lang/String;)Landroid/app/Notification$Builder;

    :cond_2
    :goto_1
    const/4 v1, 0x1

    invoke-virtual {v5, v1}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->q()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_3

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->q()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v5, v1}, Landroid/app/Notification$Builder;->setChannelId(Ljava/lang/String;)Landroid/app/Notification$Builder;

    :cond_3
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_6

    const-string v1, "android.resource://"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    :goto_2
    invoke-virtual {v5, p1}, Landroid/app/Notification$Builder;->setSound(Landroid/net/Uri;)Landroid/app/Notification$Builder;

    goto :goto_4

    :cond_4
    const-string v3, "/raw/"

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    goto :goto_3

    :cond_5
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    :goto_3
    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    goto :goto_2

    :cond_6
    :goto_4
    if-eqz p4, :cond_7

    invoke-interface {p4, v5, p3}, Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;->configBuilder(Landroid/app/Notification$Builder;Lcom/alibaba/sdk/android/push/notification/PushData;)V

    :cond_7
    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->z()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_9

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->z()Ljava/lang/String;

    move-result-object p1

    const-class p2, Landroid/app/Notification;

    invoke-virtual {p2}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object p2

    array-length p3, p2

    const/4 p4, 0x0

    :goto_5
    if-ge p4, p3, :cond_9

    aget-object v0, p2, p4

    invoke-virtual {v0}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    :try_start_0
    invoke-virtual {v0, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v5, v0}, Landroid/app/Notification$Builder;->setCategory(Ljava/lang/String;)Landroid/app/Notification$Builder;
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_6

    :catch_0
    sget-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "set category error: "

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;)V

    :cond_8
    :goto_6
    add-int/lit8 p4, p4, 0x1

    goto :goto_5

    :cond_9
    invoke-virtual {v5}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v2

    :cond_a
    return-object v2
.end method

.method public static getInstance()Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->c:Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;

    if-nez v0, :cond_0

    new-instance v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;-><init>()V

    sput-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->c:Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;

    :cond_0
    sget-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->c:Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;

    return-object v0
.end method


# virtual methods
.method public a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Lcom/alibaba/sdk/android/push/notification/PushData;Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;)Landroid/app/Notification;
    .locals 2

    const/4 v0, 0x2

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->g()I

    move-result v1

    if-ne v0, v1, :cond_0

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Lcom/alibaba/sdk/android/push/notification/PushData;Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;)Landroid/app/Notification;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 v0, 0x3

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/notification/b;->g()I

    move-result v1

    if-ne v0, v1, :cond_1

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->c(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Lcom/alibaba/sdk/android/push/notification/PushData;Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;)Landroid/app/Notification;

    move-result-object p1

    return-object p1

    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(I)Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;
    .locals 6

    const-string v0, "get custom notification failed"

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b:Ljava/util/Map;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "custom_notification_"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v1, "find custom notification from cache"

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b:Ljava/util/Map;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;

    return-object p1

    :cond_0
    sget-object v1, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v2, "do not find custom notification from cache, find it from SharedPreferences"

    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->h()Landroid/content/SharedPreferences;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x0

    invoke-interface {v1, v2, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_1

    sget-object p1, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v0, "no corresponding custom notificaiton"

    invoke-virtual {p1, v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;)V

    return-object v4

    :cond_1
    :try_start_0
    const-string v2, "UTF-8"

    invoke-static {v1, v2}, Ljava/net/URLDecoder;->decode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "ISO-8859-1"

    new-instance v5, Ljava/io/ByteArrayInputStream;

    invoke-virtual {v1, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    invoke-direct {v5, v1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    new-instance v1, Ljava/io/ObjectInputStream;

    invoke-direct {v1, v5}, Ljava/io/ObjectInputStream;-><init>(Ljava/io/InputStream;)V

    invoke-virtual {v1}, Ljava/io/ObjectInputStream;->readObject()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_9
    .catch Ljava/io/OptionalDataException; {:try_start_0 .. :try_end_0} :catch_8
    .catch Ljava/io/StreamCorruptedException; {:try_start_0 .. :try_end_0} :catch_7
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_6
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_5
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    invoke-virtual {v1}, Ljava/io/ObjectInputStream;->close()V

    invoke-virtual {v5}, Ljava/io/ByteArrayInputStream;->close()V
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_4
    .catch Ljava/io/OptionalDataException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/io/StreamCorruptedException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    if-eqz v2, :cond_2

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b:Ljava/util/Map;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_2
    return-object v2

    :catchall_0
    move-object v4, v2

    goto/16 :goto_5

    :catch_0
    move-exception v1

    move-object v4, v2

    goto :goto_0

    :catch_1
    move-exception v1

    move-object v4, v2

    goto :goto_1

    :catch_2
    move-exception v1

    move-object v4, v2

    goto :goto_2

    :catch_3
    move-exception v1

    move-object v4, v2

    goto :goto_3

    :catch_4
    move-exception v1

    move-object v4, v2

    goto/16 :goto_4

    :catch_5
    move-exception v1

    :goto_0
    :try_start_2
    sget-object v2, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    invoke-virtual {v2, v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    if-eqz v4, :cond_3

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b:Ljava/util/Map;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_3
    return-object v4

    :catch_6
    move-exception v1

    :goto_1
    :try_start_3
    sget-object v2, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    invoke-virtual {v2, v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    if-eqz v4, :cond_4

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b:Ljava/util/Map;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_4
    return-object v4

    :catch_7
    move-exception v1

    :goto_2
    :try_start_4
    sget-object v2, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    invoke-virtual {v2, v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    if-eqz v4, :cond_5

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b:Ljava/util/Map;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_5
    return-object v4

    :catch_8
    move-exception v1

    :goto_3
    :try_start_5
    sget-object v2, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    invoke-virtual {v2, v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    if-eqz v4, :cond_6

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b:Ljava/util/Map;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_6
    return-object v4

    :catch_9
    move-exception v1

    :goto_4
    :try_start_6
    sget-object v2, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    invoke-virtual {v2, v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    if-eqz v4, :cond_7

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b:Ljava/util/Map;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_7
    return-object v4

    :catchall_1
    :goto_5
    sget-object v0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    if-eqz v4, :cond_8

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b:Ljava/util/Map;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_8
    return-object v4
.end method

.method public setCustomNotification(ILcom/alibaba/sdk/android/push/notification/BasicCustomPushNotification;)Z
    .locals 7

    const-string v0, "custom_notification_"

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->a()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    sget-object p1, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string p2, "need init push first"

    :goto_0
    invoke-virtual {p1, p2}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;)V

    return v2

    :cond_0
    if-gtz p1, :cond_1

    sget-object p1, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string p2, "custom notification id must be an integer greater than 0"

    goto :goto_0

    :cond_1
    if-nez p2, :cond_2

    sget-object p1, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string p2, "notification cannot be null"

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->h()Landroid/content/SharedPreferences;

    move-result-object v1

    new-instance v3, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v3}, Ljava/io/ByteArrayOutputStream;-><init>()V

    :try_start_0
    new-instance v4, Ljava/io/ObjectOutputStream;

    invoke-direct {v4, v3}, Ljava/io/ObjectOutputStream;-><init>(Ljava/io/OutputStream;)V

    invoke-virtual {v4, p2}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V

    const-string v5, "ISO-8859-1"

    invoke-virtual {v3, v5}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "UTF-8"

    invoke-static {v5, v6}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4}, Ljava/io/ObjectOutputStream;->close()V

    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->close()V

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3, v5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v2, 0x1

    goto :goto_1

    :catch_0
    move-exception v1

    sget-object v3, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v4, "get custom notification failed"

    invoke-virtual {v3, v4, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_1
    if-eqz v2, :cond_4

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b:Ljava/util/Map;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b:Ljava/util/Map;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_3
    sget-object v1, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v3, "save the notification to cache"

    invoke-virtual {v1, v3}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/CustomNotificationBuilder;->b:Ljava/util/Map;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v1, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_4
    return v2
.end method
