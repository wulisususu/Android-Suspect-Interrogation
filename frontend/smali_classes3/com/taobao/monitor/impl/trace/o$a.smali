.class Lcom/taobao/monitor/impl/trace/o$a;
.super Ljava/lang/Object;
.source "UsableVisibleDispatcher.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/a$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/trace/o;->a(Ljava/lang/Object;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/taobao/monitor/impl/trace/a$d<",
        "Lcom/taobao/monitor/impl/data/h;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic a:J

.field final synthetic a:Lcom/taobao/monitor/impl/trace/o;

.field final synthetic a:Ljava/lang/Object;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/trace/o;Ljava/lang/Object;IJ)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/trace/o$a;->a:Lcom/taobao/monitor/impl/trace/o;

    iput-object p2, p0, Lcom/taobao/monitor/impl/trace/o$a;->a:Ljava/lang/Object;

    iput p3, p0, Lcom/taobao/monitor/impl/trace/o$a;->a:I

    iput-wide p4, p0, Lcom/taobao/monitor/impl/trace/o$a;->a:J

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/monitor/impl/data/h;)V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/o$a;->a:Ljava/lang/Object;

    iget v1, p0, Lcom/taobao/monitor/impl/trace/o$a;->a:I

    iget-wide v2, p0, Lcom/taobao/monitor/impl/trace/o$a;->a:J

    .line 2
    invoke-interface {p1, v0, v1, v2, v3}, Lcom/taobao/monitor/impl/data/h;->a(Ljava/lang/Object;IJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/taobao/monitor/impl/data/h;

    invoke-virtual {p0, p1}, Lcom/taobao/monitor/impl/trace/o$a;->a(Lcom/taobao/monitor/impl/data/h;)V

    return-void
.end method
