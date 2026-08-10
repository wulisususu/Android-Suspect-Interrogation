.class public Lcom/alibaba/sdk/android/push/e/g;
.super Ljava/lang/Object;


# static fields
.field private static final a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

.field private static b:Lcom/alibaba/sdk/android/push/e/g;

.field private static c:Landroid/content/Context;


# instance fields
.field private final d:Lcom/alibaba/sdk/android/push/e/f;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "MPS:VipRequestManager"

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->getLogger(Ljava/lang/String;)Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const/4 v0, 0x0

    sput-object v0, Lcom/alibaba/sdk/android/push/e/g;->b:Lcom/alibaba/sdk/android/push/e/g;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/alibaba/sdk/android/push/e/f;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/push/e/f;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/e/g;->d:Lcom/alibaba/sdk/android/push/e/f;

    return-void
.end method

.method public static a()Lcom/alibaba/sdk/android/push/e/g;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/push/e/g;->b:Lcom/alibaba/sdk/android/push/e/g;

    if-nez v0, :cond_0

    new-instance v0, Lcom/alibaba/sdk/android/push/e/g;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/push/e/g;-><init>()V

    sput-object v0, Lcom/alibaba/sdk/android/push/e/g;->b:Lcom/alibaba/sdk/android/push/e/g;

    :cond_0
    sget-object v0, Lcom/alibaba/sdk/android/push/e/g;->b:Lcom/alibaba/sdk/android/push/e/g;

    return-object v0
.end method

.method private a(I)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/e/g;->d:Lcom/alibaba/sdk/android/push/e/f;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/push/e/f;->a(I)Lcom/alibaba/sdk/android/push/e/f$a;

    move-result-object p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/push/e/f$a;->a()Ljava/lang/String;

    move-result-object p1

    :goto_0
    return-object p1
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "[",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v0

    const-string v1, "deviceId"

    const-string v2, "alias"

    const-string v3, "tags"

    const/4 v4, 0x0

    const-string v5, "account"

    const/4 v6, 0x1

    const/4 v7, -0x1

    sparse-switch v0, :sswitch_data_0

    goto :goto_0

    :sswitch_0
    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v7, 0x3

    goto :goto_0

    :sswitch_1
    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_1

    goto :goto_0

    :cond_1
    const/4 v7, 0x2

    goto :goto_0

    :sswitch_2
    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_2

    goto :goto_0

    :cond_2
    move v7, v6

    goto :goto_0

    :sswitch_3
    invoke-virtual {p1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_3

    goto :goto_0

    :cond_3
    move v7, v4

    :goto_0
    packed-switch v7, :pswitch_data_0

    goto/16 :goto_3

    :pswitch_0
    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->e()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_4

    invoke-interface {p4, v1, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_3

    :cond_4
    new-instance p1, Lcom/alibaba/sdk/android/push/a/c;

    const-string p2, "deviceId is empty."

    invoke-direct {p1, p2}, Lcom/alibaba/sdk/android/push/a/c;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_1
    invoke-static {p2}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_5

    invoke-interface {p4, v2, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_3

    :cond_5
    new-instance p1, Lcom/alibaba/sdk/android/push/a/c;

    const-string p2, "alias is empty"

    invoke-direct {p1, p2}, Lcom/alibaba/sdk/android/push/a/c;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_2
    const-string p1, "tags array is empty"

    if-eqz p3, :cond_a

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    :goto_1
    array-length v0, p3

    if-ge v4, v0, :cond_8

    array-length v0, p3

    sub-int/2addr v0, v6

    if-eq v4, v0, :cond_6

    aget-object v0, p3, v4

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_6

    aget-object v0, p3, v4

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_2

    :cond_6
    array-length v0, p3

    sub-int/2addr v0, v6

    if-ne v4, v0, :cond_7

    aget-object v0, p3, v4

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_7

    aget-object v0, p3, v4

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_7
    :goto_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_8
    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-static {p3}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_9

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {p4, v3, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_3

    :cond_9
    new-instance p2, Lcom/alibaba/sdk/android/push/a/c;

    invoke-direct {p2, p1}, Lcom/alibaba/sdk/android/push/a/c;-><init>(Ljava/lang/String;)V

    throw p2

    :cond_a
    new-instance p2, Lcom/alibaba/sdk/android/push/a/c;

    invoke-direct {p2, p1}, Lcom/alibaba/sdk/android/push/a/c;-><init>(Ljava/lang/String;)V

    throw p2

    :pswitch_3
    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->f()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_b

    invoke-interface {p4, v5, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :goto_3
    return-object p4

    :cond_b
    new-instance p1, Lcom/alibaba/sdk/android/push/a/c;

    const-string p2, "account is empty"

    invoke-direct {p1, p2}, Lcom/alibaba/sdk/android/push/a/c;-><init>(Ljava/lang/String;)V

    throw p1

    nop

    :sswitch_data_0
    .sparse-switch
        -0x462c75d3 -> :sswitch_3
        0x363419 -> :sswitch_2
        0x5899650 -> :sswitch_1
        0x421cea11 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private a(ILjava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/e/g;->d:Lcom/alibaba/sdk/android/push/e/f;

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/push/e/f;->a(ILjava/lang/String;)V

    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 0

    sput-object p0, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    sget-object p0, Lcom/alibaba/sdk/android/push/e/g;->b:Lcom/alibaba/sdk/android/push/e/g;

    if-nez p0, :cond_0

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/g;->a()Lcom/alibaba/sdk/android/push/e/g;

    move-result-object p0

    sput-object p0, Lcom/alibaba/sdk/android/push/e/g;->b:Lcom/alibaba/sdk/android/push/e/g;

    :cond_0
    return-void
.end method

.method private a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/Throwable;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method private a(Lcom/alibaba/sdk/android/push/a/d;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/Throwable;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/push/e/g;ILjava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/alibaba/sdk/android/push/e/g;->a(ILjava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/push/e/g;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/push/e/g;Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;J)V

    return-void
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/push/e/g;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 2

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/b/c;->a()Lcom/alibaba/sdk/android/ams/common/b/b;

    move-result-object v0

    const-string v1, "mps_account"

    invoke-interface {v0, v1, p1}, Lcom/alibaba/sdk/android/ams/common/b/b;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private a(Ljava/lang/String;J)V
    .locals 2

    invoke-static {}, Lcom/alibaba/sdk/android/push/c/a;->a()Lcom/alibaba/sdk/android/push/c/a;

    move-result-object v0

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/b/c;->a()Lcom/alibaba/sdk/android/ams/common/b/b;

    move-result-object v1

    if-eqz v0, :cond_0

    if-eqz v1, :cond_0

    invoke-interface {v1}, Lcom/alibaba/sdk/android/ams/common/b/b;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, v1, p2, p3}, Lcom/alibaba/sdk/android/push/c/a;->a(Ljava/lang/String;Ljava/lang/String;J)V

    :cond_0
    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    invoke-static {}, Lcom/alibaba/sdk/android/push/c/a;->a()Lcom/alibaba/sdk/android/push/c/a;

    move-result-object v0

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/b/c;->a()Lcom/alibaba/sdk/android/ams/common/b/b;

    move-result-object v1

    if-eqz v0, :cond_0

    if-eqz v1, :cond_0

    invoke-interface {v1}, Lcom/alibaba/sdk/android/ams/common/b/b;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, p2, v1, p3}, Lcom/alibaba/sdk/android/push/c/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private a(Ljava/lang/Throwable;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 4

    sget-object v0, Lcom/alibaba/sdk/android/push/common/global/c;->q:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v0

    sget-object v1, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " Fail: errorCode:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, p1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    if-eqz p3, :cond_0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p3, p1, v1}, Lcom/alibaba/sdk/android/push/CommonCallback;->onFailed(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object p3

    invoke-direct {p0, p1, p3, p2}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic c()Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    return-object v0
.end method

.method private static c(Landroid/content/Context;)Z
    .locals 3

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    const-string v1, "KEY_LAUNCH_MARK"

    invoke-static {p0, v1}, Lcom/alibaba/sdk/android/push/common/util/b;->a(Landroid/content/Context;Ljava/lang/String;)J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->setTimeInMillis(J)V

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object p0

    const/4 v1, 0x6

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v2

    invoke-virtual {p0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v1

    if-ne v2, v1, :cond_0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    invoke-virtual {p0, v1}, Ljava/util/Calendar;->get(I)I

    move-result p0

    if-ne v0, p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method static synthetic d()Landroid/content/Context;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    return-object v0
.end method

.method private e()Ljava/lang/String;
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/b/c;->a()Lcom/alibaba/sdk/android/ams/common/b/b;

    move-result-object v0

    invoke-interface {v0}, Lcom/alibaba/sdk/android/ams/common/b/b;->b()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private f()Ljava/lang/String;
    .locals 2

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/b/c;->a()Lcom/alibaba/sdk/android/ams/common/b/b;

    move-result-object v0

    const-string v1, "mps_account"

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/ams/common/b/b;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private g()Ljava/util/Map;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/e/g;->b()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    const-string v2, "appKey"

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "os"

    const-string v2, "2"

    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "version"

    const-string v2, "3.9.5"

    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v1
.end method


# virtual methods
.method public a(ILcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 12

    const-string v0, "/list-tag"

    const-string v1, "https://"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    sget-object v2, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v3, "listTags"

    invoke-virtual {v2, v3}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    const/4 v8, 0x1

    if-ne v8, p1, :cond_1

    const/4 v3, 0x2

    invoke-direct {p0, v3}, Lcom/alibaba/sdk/android/push/e/g;->a(I)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1

    const-string p1, "get from cache"

    invoke-virtual {v2, p1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    if-eqz p2, :cond_0

    invoke-interface {p2, v3}, Lcom/alibaba/sdk/android/push/CommonCallback;->onSuccess(Ljava/lang/String;)V

    :cond_0
    return-void

    :cond_1
    :try_start_0
    new-instance v9, Lcom/alibaba/sdk/android/push/e/h;

    sget-object v10, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v11, Lcom/alibaba/sdk/android/push/e/g$10;

    move-object v2, v11

    move-object v3, p0

    move v6, p1

    move-object v7, p2

    invoke-direct/range {v2 .. v7}, Lcom/alibaba/sdk/android/push/e/g$10;-><init>(Lcom/alibaba/sdk/android/push/e/g;JILcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {v9, v10, v1, v11}, Lcom/alibaba/sdk/android/push/e/h;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->g()Ljava/util/Map;

    move-result-object v1

    if-ne p1, v8, :cond_2

    const-string v2, "deviceId"

    const/4 v3, 0x0

    invoke-direct {p0, v2, v3, v3, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object v1

    const-string v2, "target"

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v1, v2, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "VipRequestType"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v3, Lcom/alibaba/sdk/android/push/common/util/a/d;->m:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-array p1, v8, [Ljava/util/Map;

    const/4 v2, 0x0

    aput-object v1, p1, v2

    invoke-virtual {v9, p1}, Lcom/alibaba/sdk/android/push/e/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    goto :goto_0

    :cond_2
    new-instance p1, Lcom/alibaba/sdk/android/push/a/d;

    const-string v1, "target is invalid."

    invoke-direct {p1, v1}, Lcom/alibaba/sdk/android/push/a/d;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lcom/alibaba/sdk/android/push/a/d; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception p1

    invoke-direct {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/d;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    goto :goto_0

    :catch_1
    move-exception p1

    invoke-direct {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :goto_0
    return-void
.end method

.method public a(I[Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 8

    const-string v0, "/bind-tag"

    const-string v1, "https://"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    :try_start_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v4, Lcom/alibaba/sdk/android/push/e/h;

    sget-object v5, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    new-instance v6, Lcom/alibaba/sdk/android/push/e/g$8;

    invoke-direct {v6, p0, v2, v3, p4}, Lcom/alibaba/sdk/android/push/e/g$8;-><init>(Lcom/alibaba/sdk/android/push/e/g;JLcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {v4, v5, v1, v6}, Lcom/alibaba/sdk/android/push/e/h;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    if-eqz p2, :cond_3

    array-length v1, p2

    if-eqz v1, :cond_3

    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->g()Ljava/util/Map;

    move-result-object v1
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lcom/alibaba/sdk/android/push/a/d; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v2, 0x1

    const-string v3, ""

    const-string v5, "VipRequestType"

    const/4 v6, 0x0

    if-eq p1, v2, :cond_2

    const/4 v7, 0x2

    if-eq p1, v7, :cond_1

    const/4 v7, 0x3

    if-ne p1, v7, :cond_0

    :try_start_1
    const-string v7, "alias"

    invoke-direct {p0, v7, p3, v6, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object p3

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v7, Lcom/alibaba/sdk/android/push/common/util/a/d;->g:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v7

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-interface {p3, v5, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_0
    new-instance p1, Lcom/alibaba/sdk/android/push/a/d;

    const-string p2, "target is invalid."

    invoke-direct {p1, p2}, Lcom/alibaba/sdk/android/push/a/d;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_1
    sget-object p3, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v7, "Binding tag to account."

    invoke-virtual {p3, v7}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    const-string p3, "account"

    invoke-direct {p0, p3, v6, v6, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object p3

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v7, Lcom/alibaba/sdk/android/push/common/util/a/d;->f:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v7

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_2
    sget-object p3, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v7, "Binding tag to device."

    invoke-virtual {p3, v7}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    const-string p3, "deviceId"

    invoke-direct {p0, p3, v6, v6, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object p3

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v7, Lcom/alibaba/sdk/android/push/common/util/a/d;->e:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v7

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :goto_1
    const-string v1, "tags"

    invoke-direct {p0, v1, v6, p2, p3}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object p2

    const-string p3, "target"

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    invoke-interface {p2, p3, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-array p1, v2, [Ljava/util/Map;

    const/4 p3, 0x0

    aput-object p2, p1, p3

    invoke-virtual {v4, p1}, Lcom/alibaba/sdk/android/push/e/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    goto :goto_2

    :cond_3
    new-instance p1, Lcom/alibaba/sdk/android/push/a/d;

    const-string p2, "tags is empty."

    invoke-direct {p1, p2}, Lcom/alibaba/sdk/android/push/a/d;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_1
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_1 .. :try_end_1} :catch_1
    .catch Lcom/alibaba/sdk/android/push/a/d; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    move-exception p1

    invoke-direct {p0, p1, v0, p4}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/d;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    goto :goto_2

    :catch_1
    move-exception p1

    invoke-direct {p0, p1, v0, p4}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :goto_2
    return-void
.end method

.method public a(Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 7

    sget-object v0, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v1, "unbinding account"

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    new-instance v2, Lcom/alibaba/sdk/android/push/e/h;

    sget-object v3, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "https://"

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->c()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "/unbind-account"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-instance v6, Lcom/alibaba/sdk/android/push/e/g$7;

    invoke-direct {v6, p0, v0, v1, p1}, Lcom/alibaba/sdk/android/push/e/g$7;-><init>(Lcom/alibaba/sdk/android/push/e/g;JLcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {v2, v3, v4, v6}, Lcom/alibaba/sdk/android/push/e/h;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :try_start_0
    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->g()Ljava/util/Map;

    move-result-object v0

    const-string v1, "account"

    const-string v3, ""

    invoke-interface {v0, v1, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "VipRequestType"

    sget-object v3, Lcom/alibaba/sdk/android/push/common/util/a/d;->d:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v1, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "deviceId"

    const/4 v3, 0x0

    invoke-direct {p0, v1, v3, v3, v0}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/util/Map;

    const/4 v3, 0x0

    aput-object v0, v1, v3

    invoke-virtual {v2, v1}, Lcom/alibaba/sdk/android/push/e/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-direct {p0, v0, v5, p1}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :goto_0
    return-void
.end method

.method public a(Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 11

    const-string v0, "/bind-account"

    const-string v1, "https://"

    sget-object v2, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "binding account"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    :try_start_0
    new-instance v2, Lcom/alibaba/sdk/android/push/e/h;

    sget-object v3, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v10, Lcom/alibaba/sdk/android/push/e/g$1;

    move-object v4, v10

    move-object v5, p0

    move-object v6, p1

    move-object v9, p2

    invoke-direct/range {v4 .. v9}, Lcom/alibaba/sdk/android/push/e/g$1;-><init>(Lcom/alibaba/sdk/android/push/e/g;Ljava/lang/String;JLcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {v2, v3, v1, v10}, Lcom/alibaba/sdk/android/push/e/h;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->g()Ljava/util/Map;

    move-result-object v1

    invoke-static {p1}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    const-string v3, "account"

    invoke-interface {v1, v3, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "VipRequestType"

    sget-object v3, Lcom/alibaba/sdk/android/push/common/util/a/d;->c:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, p1, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "deviceId"

    const/4 v3, 0x0

    invoke-direct {p0, p1, v3, v3, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object p1

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/util/Map;

    const/4 v3, 0x0

    aput-object p1, v1, v3

    invoke-virtual {v2, v1}, Lcom/alibaba/sdk/android/push/e/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    goto :goto_0

    :cond_0
    new-instance p1, Lcom/alibaba/sdk/android/push/a/d;

    const-string v1, "account input is empty!"

    invoke-direct {p1, v1}, Lcom/alibaba/sdk/android/push/a/d;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lcom/alibaba/sdk/android/push/a/d; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception p1

    invoke-direct {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/d;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    goto :goto_0

    :catch_1
    move-exception p1

    invoke-direct {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :goto_0
    return-void
.end method

.method public b()Ljava/lang/String;
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/b/c;->a()Lcom/alibaba/sdk/android/ams/common/b/b;

    move-result-object v0

    invoke-interface {v0}, Lcom/alibaba/sdk/android/ams/common/b/b;->a()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public b(I[Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 9

    const-string v0, "/unbind-tag"

    const-string v1, "https://"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    :try_start_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v4, Lcom/alibaba/sdk/android/push/e/h;

    sget-object v5, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    new-instance v6, Lcom/alibaba/sdk/android/push/e/g$9;

    invoke-direct {v6, p0, p4, v2, v3}, Lcom/alibaba/sdk/android/push/e/g$9;-><init>(Lcom/alibaba/sdk/android/push/e/g;Lcom/alibaba/sdk/android/push/CommonCallback;J)V

    invoke-direct {v4, v5, v1, v6}, Lcom/alibaba/sdk/android/push/e/h;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->g()Ljava/util/Map;

    move-result-object v1
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lcom/alibaba/sdk/android/push/a/d; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v2, 0x1

    const-string v3, ""

    const-string v5, "VipRequestType"

    const/4 v6, 0x0

    if-eq p1, v2, :cond_2

    const/4 v7, 0x2

    if-eq p1, v7, :cond_1

    const/4 v7, 0x3

    if-ne p1, v7, :cond_0

    :try_start_1
    sget-object v7, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v8, "Unbinding tag from alias."

    invoke-virtual {v7, v8}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    const-string v7, "alias"

    invoke-direct {p0, v7, p3, v6, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object p3

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v7, Lcom/alibaba/sdk/android/push/common/util/a/d;->k:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v7

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-interface {p3, v5, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_0
    new-instance p1, Lcom/alibaba/sdk/android/push/a/d;

    const-string p2, "target is invalid."

    invoke-direct {p1, p2}, Lcom/alibaba/sdk/android/push/a/d;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_1
    sget-object p3, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v7, "Unbinding tag from account."

    invoke-virtual {p3, v7}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    const-string p3, "account"

    invoke-direct {p0, p3, v6, v6, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object p3

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v7, Lcom/alibaba/sdk/android/push/common/util/a/d;->j:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v7

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_2
    sget-object p3, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v7, "Unbinding tag from device."

    invoke-virtual {p3, v7}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    const-string p3, "deviceId"

    invoke-direct {p0, p3, v6, v6, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object p3

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v7, Lcom/alibaba/sdk/android/push/common/util/a/d;->i:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v7

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :goto_1
    const-string v1, "tags"

    invoke-direct {p0, v1, v6, p2, p3}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object p2

    const-string p3, "target"

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    invoke-interface {p2, p3, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-array p1, v2, [Ljava/util/Map;

    const/4 p3, 0x0

    aput-object p2, p1, p3

    invoke-virtual {v4, p1}, Lcom/alibaba/sdk/android/push/e/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_1
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_1 .. :try_end_1} :catch_1
    .catch Lcom/alibaba/sdk/android/push/a/d; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    move-exception p1

    invoke-direct {p0, p1, v0, p4}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/d;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    goto :goto_2

    :catch_1
    move-exception p1

    invoke-direct {p0, p1, v0, p4}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :goto_2
    return-void
.end method

.method public b(Landroid/content/Context;)V
    .locals 5

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/e/g;->c(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_0

    sget-object p1, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v0, "onAppStart has already sent today"

    invoke-virtual {p1, v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object p1, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v0, "onAppStart"

    invoke-virtual {p1, v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    new-instance p1, Lcom/alibaba/sdk/android/push/e/h;

    sget-object v0, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "https://"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->c()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/active"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v3, Lcom/alibaba/sdk/android/push/e/g$6;

    invoke-direct {v3, p0}, Lcom/alibaba/sdk/android/push/e/g$6;-><init>(Lcom/alibaba/sdk/android/push/e/g;)V

    invoke-direct {p1, v0, v1, v3}, Lcom/alibaba/sdk/android/push/e/h;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    const/4 v0, 0x0

    :try_start_0
    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->g()Ljava/util/Map;

    move-result-object v1

    const-string v3, "VipRequestType"

    sget-object v4, Lcom/alibaba/sdk/android/push/common/util/a/d;->t:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v4

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v1, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v3, "deviceId"

    invoke-direct {p0, v3, v0, v0, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object v1

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/util/Map;

    const/4 v4, 0x0

    aput-object v1, v3, v4

    invoke-virtual {p1, v3}, Lcom/alibaba/sdk/android/push/e/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-direct {p0, p1, v2, v0}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :goto_0
    return-void
.end method

.method public b(Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 8

    const-string v0, "/list-alias"

    const-string v1, "https://"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sget-object v4, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v5, "listAliases"

    invoke-virtual {v4, v5}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    const/4 v5, 0x1

    invoke-direct {p0, v5}, Lcom/alibaba/sdk/android/push/e/g;->a(I)Ljava/lang/String;

    move-result-object v6

    if-eqz v6, :cond_1

    const-string v0, "get from cache"

    invoke-virtual {v4, v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    if-eqz p1, :cond_0

    invoke-interface {p1, v6}, Lcom/alibaba/sdk/android/push/CommonCallback;->onSuccess(Ljava/lang/String;)V

    :cond_0
    return-void

    :cond_1
    :try_start_0
    new-instance v4, Lcom/alibaba/sdk/android/push/e/h;

    sget-object v6, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v7, Lcom/alibaba/sdk/android/push/e/g$13;

    invoke-direct {v7, p0, v2, v3, p1}, Lcom/alibaba/sdk/android/push/e/g$13;-><init>(Lcom/alibaba/sdk/android/push/e/g;JLcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {v4, v6, v1, v7}, Lcom/alibaba/sdk/android/push/e/h;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->g()Ljava/util/Map;

    move-result-object v1

    const-string v2, "VipRequestType"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v6, Lcom/alibaba/sdk/android/push/common/util/a/d;->n:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, ""

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v2, "deviceId"

    const/4 v3, 0x0

    invoke-direct {p0, v2, v3, v3, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object v1

    new-array v2, v5, [Ljava/util/Map;

    const/4 v3, 0x0

    aput-object v1, v2, v3

    invoke-virtual {v4, v2}, Lcom/alibaba/sdk/android/push/e/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    invoke-direct {p0, v1, v0, p1}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :goto_0
    return-void
.end method

.method public b(Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 7

    const-string v0, "/add-alias"

    const-string v1, "https://"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sget-object v4, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v5, "Adding alias to device"

    invoke-virtual {v4, v5}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    :try_start_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v4, Lcom/alibaba/sdk/android/push/e/h;

    sget-object v5, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    new-instance v6, Lcom/alibaba/sdk/android/push/e/g$11;

    invoke-direct {v6, p0, v2, v3, p2}, Lcom/alibaba/sdk/android/push/e/g$11;-><init>(Lcom/alibaba/sdk/android/push/e/g;JLcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {v4, v5, v1, v6}, Lcom/alibaba/sdk/android/push/e/h;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->g()Ljava/util/Map;

    move-result-object v1

    const-string v2, "deviceId"

    const/4 v3, 0x0

    invoke-direct {p0, v2, v3, v3, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object v1

    const-string v2, "alias"

    invoke-direct {p0, v2, p1, v3, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object p1

    const-string v1, "VipRequestType"

    sget-object v2, Lcom/alibaba/sdk/android/push/common/util/a/d;->h:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {p1, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/util/Map;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-virtual {v4, v1}, Lcom/alibaba/sdk/android/push/e/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-direct {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :goto_0
    return-void
.end method

.method public c(Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 7

    const-string v0, "/push-status"

    const-string v1, "https://"

    sget-object v2, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v3, "check vip push status"

    invoke-virtual {v2, v3}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    :try_start_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v4, Lcom/alibaba/sdk/android/push/e/h;

    sget-object v5, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    new-instance v6, Lcom/alibaba/sdk/android/push/e/g$14;

    invoke-direct {v6, p0, v2, v3, p1}, Lcom/alibaba/sdk/android/push/e/g$14;-><init>(Lcom/alibaba/sdk/android/push/e/g;JLcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {v4, v5, v1, v6}, Lcom/alibaba/sdk/android/push/e/h;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->g()Ljava/util/Map;

    move-result-object v1

    const-string v2, "deviceId"

    const/4 v3, 0x0

    invoke-direct {p0, v2, v3, v3, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object v1

    const-string v2, "VipRequestType"

    sget-object v3, Lcom/alibaba/sdk/android/push/common/util/a/d;->q:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/util/Map;

    const/4 v3, 0x0

    aput-object v1, v2, v3

    invoke-virtual {v4, v2}, Lcom/alibaba/sdk/android/push/e/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    invoke-direct {p0, v1, v0, p1}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :goto_0
    return-void
.end method

.method public c(Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 7

    const-string v0, "/remove-alias"

    const-string v1, "https://"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sget-object v4, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v5, "Removing alias from device"

    invoke-virtual {v4, v5}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    :try_start_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v4, Lcom/alibaba/sdk/android/push/e/h;

    sget-object v5, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    new-instance v6, Lcom/alibaba/sdk/android/push/e/g$12;

    invoke-direct {v6, p0, v2, v3, p2}, Lcom/alibaba/sdk/android/push/e/g$12;-><init>(Lcom/alibaba/sdk/android/push/e/g;JLcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {v4, v5, v1, v6}, Lcom/alibaba/sdk/android/push/e/h;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->g()Ljava/util/Map;

    move-result-object v1

    const-string v2, "deviceId"

    const/4 v3, 0x0

    invoke-direct {p0, v2, v3, v3, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object v1

    invoke-static {p1}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string p1, ""

    :cond_0
    const-string v2, "alias"

    invoke-interface {v1, v2, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "VipRequestType"

    sget-object v2, Lcom/alibaba/sdk/android/push/common/util/a/d;->l:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 p1, 0x1

    new-array p1, p1, [Ljava/util/Map;

    const/4 v2, 0x0

    aput-object v1, p1, v2

    invoke-virtual {v4, p1}, Lcom/alibaba/sdk/android/push/e/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-direct {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :goto_0
    return-void
.end method

.method public d(Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 6

    const-string v0, "https://"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    sget-object v3, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v4, "unbinding vip"

    invoke-virtual {v3, v4}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    :try_start_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->c()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "/push-switch"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v3, Lcom/alibaba/sdk/android/push/e/h;

    sget-object v4, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    new-instance v5, Lcom/alibaba/sdk/android/push/e/g$2;

    invoke-direct {v5, p0, v1, v2, p1}, Lcom/alibaba/sdk/android/push/e/g$2;-><init>(Lcom/alibaba/sdk/android/push/e/g;JLcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {v3, v4, v0, v5}, Lcom/alibaba/sdk/android/push/e/h;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->g()Ljava/util/Map;

    move-result-object v0

    const-string v1, "deviceId"

    const/4 v2, 0x0

    invoke-direct {p0, v1, v2, v2, v0}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    const-string v1, "VipRequestType"

    sget-object v2, Lcom/alibaba/sdk/android/push/common/util/a/d;->o:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "enable"

    const-string v2, "false"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/util/Map;

    const/4 v2, 0x0

    aput-object v0, v1, v2

    invoke-virtual {v3, v1}, Lcom/alibaba/sdk/android/push/e/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "/push-switch false"

    invoke-direct {p0, v0, v1, p1}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :goto_0
    return-void
.end method

.method public d(Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 7

    const-string v0, "/set-phone"

    const-string v1, "https://"

    sget-object v2, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "binding phoneNumber:"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    :try_start_0
    new-instance v4, Lcom/alibaba/sdk/android/push/e/h;

    sget-object v5, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v6, Lcom/alibaba/sdk/android/push/e/g$4;

    invoke-direct {v6, p0, v2, v3, p2}, Lcom/alibaba/sdk/android/push/e/g$4;-><init>(Lcom/alibaba/sdk/android/push/e/g;JLcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {v4, v5, v1, v6}, Lcom/alibaba/sdk/android/push/e/h;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->g()Ljava/util/Map;

    move-result-object v1

    invoke-static {p1}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "mob"

    invoke-interface {v1, v2, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "VipRequestType"

    sget-object v2, Lcom/alibaba/sdk/android/push/common/util/a/d;->r:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "deviceId"

    const/4 v2, 0x0

    invoke-direct {p0, p1, v2, v2, v1}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object p1

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/util/Map;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-virtual {v4, v1}, Lcom/alibaba/sdk/android/push/e/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    goto :goto_0

    :cond_0
    new-instance p1, Lcom/alibaba/sdk/android/push/a/d;

    const-string v1, "account input is empty!"

    invoke-direct {p1, v1}, Lcom/alibaba/sdk/android/push/a/d;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lcom/alibaba/sdk/android/push/a/d; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception p1

    invoke-direct {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/d;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    goto :goto_0

    :catch_1
    move-exception p1

    invoke-direct {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :goto_0
    return-void
.end method

.method public e(Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 6

    const-string v0, "https://"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    sget-object v3, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v4, "binding vip push"

    invoke-virtual {v3, v4}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    :try_start_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->c()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "/push-switch"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v3, Lcom/alibaba/sdk/android/push/e/h;

    sget-object v4, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    new-instance v5, Lcom/alibaba/sdk/android/push/e/g$3;

    invoke-direct {v5, p0, v1, v2, p1}, Lcom/alibaba/sdk/android/push/e/g$3;-><init>(Lcom/alibaba/sdk/android/push/e/g;JLcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {v3, v4, v0, v5}, Lcom/alibaba/sdk/android/push/e/h;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->g()Ljava/util/Map;

    move-result-object v0

    const-string v1, "deviceId"

    const/4 v2, 0x0

    invoke-direct {p0, v1, v2, v2, v0}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    const-string v1, "VipRequestType"

    sget-object v2, Lcom/alibaba/sdk/android/push/common/util/a/d;->p:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "enable"

    const-string v2, "true"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/util/Map;

    const/4 v2, 0x0

    aput-object v0, v1, v2

    invoke-virtual {v3, v1}, Lcom/alibaba/sdk/android/push/e/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "/push-switch true"

    invoke-direct {p0, v0, v1, p1}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :goto_0
    return-void
.end method

.method public f(Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 7

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sget-object v2, Lcom/alibaba/sdk/android/push/e/g;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v3, "unbinding phone number"

    invoke-virtual {v2, v3}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    new-instance v2, Lcom/alibaba/sdk/android/push/e/h;

    sget-object v3, Lcom/alibaba/sdk/android/push/e/g;->c:Landroid/content/Context;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "https://"

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->c()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "/unset-phone"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-instance v6, Lcom/alibaba/sdk/android/push/e/g$5;

    invoke-direct {v6, p0, v0, v1, p1}, Lcom/alibaba/sdk/android/push/e/g$5;-><init>(Lcom/alibaba/sdk/android/push/e/g;JLcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-direct {v2, v3, v4, v6}, Lcom/alibaba/sdk/android/push/e/h;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :try_start_0
    invoke-direct {p0}, Lcom/alibaba/sdk/android/push/e/g;->g()Ljava/util/Map;

    move-result-object v0

    const-string v1, "VipRequestType"

    sget-object v3, Lcom/alibaba/sdk/android/push/common/util/a/d;->s:Lcom/alibaba/sdk/android/push/common/util/a/d;

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/push/common/util/a/d;->a()I

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v1, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "deviceId"

    const/4 v3, 0x0

    invoke-direct {p0, v1, v3, v3, v0}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/util/Map;

    const/4 v3, 0x0

    aput-object v0, v1, v3

    invoke-virtual {v2, v1}, Lcom/alibaba/sdk/android/push/e/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/c; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-direct {p0, v0, v5, p1}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/a/c;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    :goto_0
    return-void
.end method
