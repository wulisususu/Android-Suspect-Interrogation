.class Lcom/taobao/monitor/impl/common/a$b;
.super Ljava/lang/Object;
.source "APMContext.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/impl/common/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "b"
.end annotation


# static fields
.field private static final a:Lcom/taobao/monitor/impl/common/a;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/common/a;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/monitor/impl/common/a;-><init>(Lcom/taobao/monitor/impl/common/a$a;)V

    sput-object v0, Lcom/taobao/monitor/impl/common/a$b;->a:Lcom/taobao/monitor/impl/common/a;

    return-void
.end method

.method static synthetic a()Lcom/taobao/monitor/impl/common/a;
    .locals 1

    sget-object v0, Lcom/taobao/monitor/impl/common/a$b;->a:Lcom/taobao/monitor/impl/common/a;

    return-object v0
.end method
