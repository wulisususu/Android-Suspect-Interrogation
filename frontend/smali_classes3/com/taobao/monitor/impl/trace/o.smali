.class public Lcom/taobao/monitor/impl/trace/o;
.super Lcom/taobao/monitor/impl/trace/a;
.source "UsableVisibleDispatcher.java"

# interfaces
.implements Lcom/taobao/monitor/impl/data/h;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Lcom/taobao/monitor/impl/trace/a<",
        "Lcom/taobao/monitor/impl/data/h;",
        ">;",
        "Lcom/taobao/monitor/impl/data/h;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/a;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Object;FJ)V
    .locals 7

    .line 4
    new-instance v6, Lcom/taobao/monitor/impl/trace/o$d;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move-wide v4, p3

    invoke-direct/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/o$d;-><init>(Lcom/taobao/monitor/impl/trace/o;Ljava/lang/Object;FJ)V

    invoke-virtual {p0, v6}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public a(Ljava/lang/Object;IIJ)V
    .locals 8

    .line 2
    new-instance v7, Lcom/taobao/monitor/impl/trace/o$b;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move v4, p3

    move-wide v5, p4

    invoke-direct/range {v0 .. v6}, Lcom/taobao/monitor/impl/trace/o$b;-><init>(Lcom/taobao/monitor/impl/trace/o;Ljava/lang/Object;IIJ)V

    invoke-virtual {p0, v7}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public a(Ljava/lang/Object;IJ)V
    .locals 7

    .line 1
    new-instance v6, Lcom/taobao/monitor/impl/trace/o$a;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move-wide v4, p3

    invoke-direct/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/o$a;-><init>(Lcom/taobao/monitor/impl/trace/o;Ljava/lang/Object;IJ)V

    invoke-virtual {p0, v6}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public a(Ljava/lang/Object;JJ)V
    .locals 8

    .line 3
    new-instance v7, Lcom/taobao/monitor/impl/trace/o$c;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move-wide v3, p2

    move-wide v5, p4

    invoke-direct/range {v0 .. v6}, Lcom/taobao/monitor/impl/trace/o$c;-><init>(Lcom/taobao/monitor/impl/trace/o;Ljava/lang/Object;JJ)V

    invoke-virtual {p0, v7}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method
