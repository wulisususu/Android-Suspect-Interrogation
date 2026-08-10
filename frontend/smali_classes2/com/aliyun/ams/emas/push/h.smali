.class public Lcom/aliyun/ams/emas/push/h;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field public static a:Ljava/lang/String;

.field private static b:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field private static c:Lcom/aliyun/ams/emas/push/f;

.field private static d:Lcom/aliyun/ams/emas/push/IReportPushArrive;

.field private static e:I

.field private static f:I

.field private static g:Ljava/util/Random;

.field public static final importantLogger:Lcom/alibaba/sdk/android/logger/ILog;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const-string v0, "[MPS]"

    .line 18
    invoke-static {v0}, Lcom/taobao/accs/utl/AccsLogger;->getLogger(Ljava/lang/Object;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    sput-object v0, Lcom/aliyun/ams/emas/push/h;->importantLogger:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "com.alibaba.sdk.android.push.NOTIFY_ACTION"

    sput-object v0, Lcom/aliyun/ams/emas/push/h;->a:Ljava/lang/String;

    const/4 v0, 0x0

    sput-object v0, Lcom/aliyun/ams/emas/push/h;->b:Ljava/lang/Class;

    sput-object v0, Lcom/aliyun/ams/emas/push/h;->c:Lcom/aliyun/ams/emas/push/f;

    sput-object v0, Lcom/aliyun/ams/emas/push/h;->d:Lcom/aliyun/ams/emas/push/IReportPushArrive;

    const/4 v1, 0x0

    sput v1, Lcom/aliyun/ams/emas/push/h;->e:I

    sput v1, Lcom/aliyun/ams/emas/push/h;->f:I

    sput-object v0, Lcom/aliyun/ams/emas/push/h;->g:Ljava/util/Random;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a()Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation

    sget-object v0, Lcom/aliyun/ams/emas/push/h;->b:Ljava/lang/Class;

    return-object v0
.end method

.method public static a(IIIILcom/aliyun/ams/emas/push/CommonCallback;)V
    .locals 6

    sget-object v0, Lcom/aliyun/ams/emas/push/h;->c:Lcom/aliyun/ams/emas/push/f;

    move v1, p0

    move v2, p1

    move v3, p2

    move v4, p3

    move-object v5, p4

    .line 72
    invoke-virtual/range {v0 .. v5}, Lcom/aliyun/ams/emas/push/f;->a(IIIILcom/aliyun/ams/emas/push/CommonCallback;)V

    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 1

    .line 35
    new-instance v0, Lcom/aliyun/ams/emas/push/f;

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    invoke-direct {v0, p0}, Lcom/aliyun/ams/emas/push/f;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/aliyun/ams/emas/push/h;->c:Lcom/aliyun/ams/emas/push/f;

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;I)V
    .locals 1

    sget-object v0, Lcom/aliyun/ams/emas/push/h;->d:Lcom/aliyun/ams/emas/push/IReportPushArrive;

    if-eqz v0, :cond_0

    .line 87
    invoke-interface {v0, p0, p1, p2}, Lcom/aliyun/ams/emas/push/IReportPushArrive;->reportPushArrive(Landroid/content/Context;Ljava/lang/String;I)V

    :cond_0
    return-void
.end method

.method public static a(Lcom/aliyun/ams/emas/push/IReportPushArrive;)V
    .locals 0

    sput-object p0, Lcom/aliyun/ams/emas/push/h;->d:Lcom/aliyun/ams/emas/push/IReportPushArrive;

    return-void
.end method

.method public static a(Lcom/aliyun/ams/emas/push/notification/CPushMessage;)V
    .locals 1

    sget-object v0, Lcom/aliyun/ams/emas/push/h;->c:Lcom/aliyun/ams/emas/push/f;

    .line 130
    invoke-virtual {v0, p0}, Lcom/aliyun/ams/emas/push/f;->a(Lcom/aliyun/ams/emas/push/notification/CPushMessage;)V

    return-void
.end method

.method public static a(Ljava/lang/Class;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)V"
        }
    .end annotation

    sput-object p0, Lcom/aliyun/ams/emas/push/h;->b:Ljava/lang/Class;

    return-void
.end method

.method public static a(Z)V
    .locals 1

    sget-object v0, Lcom/aliyun/ams/emas/push/h;->c:Lcom/aliyun/ams/emas/push/f;

    .line 63
    invoke-virtual {v0, p0}, Lcom/aliyun/ams/emas/push/f;->a(Z)V

    return-void
.end method

.method public static b(Lcom/aliyun/ams/emas/push/notification/CPushMessage;)V
    .locals 1

    sget-object v0, Lcom/aliyun/ams/emas/push/h;->c:Lcom/aliyun/ams/emas/push/f;

    .line 139
    invoke-virtual {v0, p0}, Lcom/aliyun/ams/emas/push/f;->b(Lcom/aliyun/ams/emas/push/notification/CPushMessage;)V

    return-void
.end method

.method public static b()Z
    .locals 1

    sget-object v0, Lcom/aliyun/ams/emas/push/h;->c:Lcom/aliyun/ams/emas/push/f;

    .line 79
    invoke-virtual {v0}, Lcom/aliyun/ams/emas/push/f;->a()Z

    move-result v0

    return v0
.end method

.method public static c()I
    .locals 3

    sget v0, Lcom/aliyun/ams/emas/push/h;->f:I

    if-nez v0, :cond_1

    sget-object v0, Lcom/aliyun/ams/emas/push/h;->g:Ljava/util/Random;

    if-nez v0, :cond_0

    .line 97
    new-instance v0, Ljava/util/Random;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Ljava/util/Random;-><init>(J)V

    sput-object v0, Lcom/aliyun/ams/emas/push/h;->g:Ljava/util/Random;

    :cond_0
    sget-object v0, Lcom/aliyun/ams/emas/push/h;->g:Ljava/util/Random;

    const v1, 0xf4240

    .line 100
    invoke-virtual {v0, v1}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    sput v0, Lcom/aliyun/ams/emas/push/h;->f:I

    if-gez v0, :cond_1

    mul-int/lit8 v0, v0, -0x1

    sput v0, Lcom/aliyun/ams/emas/push/h;->f:I

    :cond_1
    sget v0, Lcom/aliyun/ams/emas/push/h;->f:I

    add-int/lit8 v1, v0, 0x1

    sput v1, Lcom/aliyun/ams/emas/push/h;->f:I

    return v0
.end method

.method public static d()I
    .locals 3

    sget v0, Lcom/aliyun/ams/emas/push/h;->e:I

    if-nez v0, :cond_1

    sget-object v0, Lcom/aliyun/ams/emas/push/h;->g:Ljava/util/Random;

    if-nez v0, :cond_0

    .line 114
    new-instance v0, Ljava/util/Random;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Ljava/util/Random;-><init>(J)V

    sput-object v0, Lcom/aliyun/ams/emas/push/h;->g:Ljava/util/Random;

    :cond_0
    sget-object v0, Lcom/aliyun/ams/emas/push/h;->g:Ljava/util/Random;

    const v1, 0xf4240

    .line 117
    invoke-virtual {v0, v1}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    sput v0, Lcom/aliyun/ams/emas/push/h;->e:I

    if-gez v0, :cond_1

    mul-int/lit8 v0, v0, -0x1

    sput v0, Lcom/aliyun/ams/emas/push/h;->e:I

    :cond_1
    sget v0, Lcom/aliyun/ams/emas/push/h;->e:I

    add-int/lit8 v1, v0, 0x1

    sput v1, Lcom/aliyun/ams/emas/push/h;->e:I

    return v0
.end method
