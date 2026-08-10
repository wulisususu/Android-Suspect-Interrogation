.class public Lcom/alibaba/sdk/android/push/e/f;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/sdk/android/push/e/f$a;
    }
.end annotation


# instance fields
.field private final a:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/Integer;",
            "Lcom/alibaba/sdk/android/push/e/f$a;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/e/f;->a:Ljava/util/concurrent/ConcurrentHashMap;

    return-void
.end method

.method private a(JJ)Z
    .locals 0

    sub-long/2addr p3, p1

    const-wide/16 p1, 0x1388

    cmp-long p1, p3, p1

    if-ltz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method


# virtual methods
.method public a(I)Lcom/alibaba/sdk/android/push/e/f$a;
    .locals 5

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/e/f;->a:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/alibaba/sdk/android/push/e/f$a;

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    :cond_0
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/push/e/f$a;->b()J

    move-result-wide v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-direct {p0, v1, v2, v3, v4}, Lcom/alibaba/sdk/android/push/e/f;->a(JJ)Z

    move-result v1

    if-eqz v1, :cond_1

    return-object v0

    :cond_1
    return-object p1
.end method

.method public a(ILjava/lang/String;)V
    .locals 4

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    const/4 v2, 0x1

    if-eq p1, v2, :cond_3

    const/4 v2, 0x2

    if-eq p1, v2, :cond_2

    const/4 v2, 0x3

    if-eq p1, v2, :cond_1

    const/4 v2, 0x4

    if-eq p1, v2, :cond_0

    goto :goto_1

    :cond_0
    new-instance p1, Lcom/alibaba/sdk/android/push/e/f$a;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-direct {p1, v3, p2, v0, v1}, Lcom/alibaba/sdk/android/push/e/f$a;-><init>(Ljava/lang/String;Ljava/lang/String;J)V

    goto :goto_0

    :cond_1
    new-instance p1, Lcom/alibaba/sdk/android/push/e/f$a;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-direct {p1, v3, p2, v0, v1}, Lcom/alibaba/sdk/android/push/e/f$a;-><init>(Ljava/lang/String;Ljava/lang/String;J)V

    goto :goto_0

    :cond_2
    new-instance p1, Lcom/alibaba/sdk/android/push/e/f$a;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-direct {p1, v3, p2, v0, v1}, Lcom/alibaba/sdk/android/push/e/f$a;-><init>(Ljava/lang/String;Ljava/lang/String;J)V

    goto :goto_0

    :cond_3
    new-instance p1, Lcom/alibaba/sdk/android/push/e/f$a;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-direct {p1, v3, p2, v0, v1}, Lcom/alibaba/sdk/android/push/e/f$a;-><init>(Ljava/lang/String;Ljava/lang/String;J)V

    :goto_0
    iget-object p2, p0, Lcom/alibaba/sdk/android/push/e/f;->a:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p2, v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :goto_1
    return-void
.end method
