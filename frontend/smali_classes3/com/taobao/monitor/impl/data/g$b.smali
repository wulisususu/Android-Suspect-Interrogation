.class Lcom/taobao/monitor/impl/data/g$b;
.super Ljava/lang/Object;
.source "LineTreeCalculator.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/impl/data/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "b"
.end annotation


# static fields
.field private static a:Ljava/util/Queue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Queue<",
            "Lcom/taobao/monitor/impl/data/g$b;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field a:I

.field b:I

.field c:I

.field d:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    sput-object v0, Lcom/taobao/monitor/impl/data/g$b;->a:Ljava/util/Queue;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a(III)Lcom/taobao/monitor/impl/data/g$b;
    .locals 0

    .line 2
    invoke-static {p0, p1, p2}, Lcom/taobao/monitor/impl/data/g$b;->b(III)Lcom/taobao/monitor/impl/data/g$b;

    move-result-object p0

    return-object p0
.end method

.method private a()V
    .locals 2

    sget-object v0, Lcom/taobao/monitor/impl/data/g$b;->a:Ljava/util/Queue;

    .line 3
    invoke-interface {v0}, Ljava/util/Queue;->size()I

    move-result v0

    const/16 v1, 0x64

    if-ge v0, v1, :cond_0

    sget-object v0, Lcom/taobao/monitor/impl/data/g$b;->a:Ljava/util/Queue;

    .line 4
    invoke-interface {v0, p0}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/g$b;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/g$b;->a()V

    return-void
.end method

.method private static b(III)Lcom/taobao/monitor/impl/data/g$b;
    .locals 1

    sget-object v0, Lcom/taobao/monitor/impl/data/g$b;->a:Ljava/util/Queue;

    .line 1
    invoke-interface {v0}, Ljava/util/Queue;->poll()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/g$b;

    if-nez v0, :cond_0

    .line 3
    new-instance v0, Lcom/taobao/monitor/impl/data/g$b;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/data/g$b;-><init>()V

    .line 5
    :cond_0
    iput p0, v0, Lcom/taobao/monitor/impl/data/g$b;->a:I

    .line 6
    iput p1, v0, Lcom/taobao/monitor/impl/data/g$b;->b:I

    .line 7
    iput p2, v0, Lcom/taobao/monitor/impl/data/g$b;->c:I

    return-object v0
.end method
