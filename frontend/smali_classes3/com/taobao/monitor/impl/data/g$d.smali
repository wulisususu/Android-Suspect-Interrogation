.class Lcom/taobao/monitor/impl/data/g$d;
.super Ljava/lang/Object;
.source "LineTreeCalculator.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/impl/data/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "d"
.end annotation


# instance fields
.field a:I

.field a:Lcom/taobao/monitor/impl/data/g$d;

.field b:I

.field b:Lcom/taobao/monitor/impl/data/g$d;

.field c:I

.field d:I


# direct methods
.method constructor <init>(III)V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/g$d;->a:Lcom/taobao/monitor/impl/data/g$d;

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/g$d;->b:Lcom/taobao/monitor/impl/data/g$d;

    if-lez p1, :cond_0

    sub-int v0, p3, p2

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/taobao/monitor/impl/data/g$d;->a:I

    :cond_0
    iput p1, p0, Lcom/taobao/monitor/impl/data/g$d;->b:I

    iput p2, p0, Lcom/taobao/monitor/impl/data/g$d;->c:I

    iput p3, p0, Lcom/taobao/monitor/impl/data/g$d;->d:I

    return-void
.end method
