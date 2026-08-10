.class public Lcom/taobao/monitor/impl/common/a;
.super Ljava/lang/Object;
.source "APMContext.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/common/a$b;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/monitor/impl/common/a$a;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/common/a;-><init>()V

    return-void
.end method

.method public static a()Lcom/taobao/monitor/impl/common/a;
    .locals 1

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/common/a$b;->a()Lcom/taobao/monitor/impl/common/a;

    move-result-object v0

    return-object v0
.end method

.method public static a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;
    .locals 0

    .line 2
    invoke-static {p0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object p0

    return-object p0
.end method
