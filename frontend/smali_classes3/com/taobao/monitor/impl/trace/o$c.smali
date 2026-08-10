.class Lcom/taobao/monitor/impl/trace/o$c;
.super Ljava/lang/Object;
.source "UsableVisibleDispatcher.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/a$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/trace/o;->a(Ljava/lang/Object;JJ)V
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
.field final synthetic a:J

.field final synthetic a:Lcom/taobao/monitor/impl/trace/o;

.field final synthetic a:Ljava/lang/Object;

.field final synthetic b:J


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/trace/o;Ljava/lang/Object;JJ)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/trace/o$c;->a:Lcom/taobao/monitor/impl/trace/o;

    iput-object p2, p0, Lcom/taobao/monitor/impl/trace/o$c;->a:Ljava/lang/Object;

    iput-wide p3, p0, Lcom/taobao/monitor/impl/trace/o$c;->a:J

    iput-wide p5, p0, Lcom/taobao/monitor/impl/trace/o$c;->b:J

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/monitor/impl/data/h;)V
    .locals 6

    iget-object v1, p0, Lcom/taobao/monitor/impl/trace/o$c;->a:Ljava/lang/Object;

    iget-wide v2, p0, Lcom/taobao/monitor/impl/trace/o$c;->a:J

    iget-wide v4, p0, Lcom/taobao/monitor/impl/trace/o$c;->b:J

    move-object v0, p1

    .line 2
    invoke-interface/range {v0 .. v5}, Lcom/taobao/monitor/impl/data/h;->a(Ljava/lang/Object;JJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/taobao/monitor/impl/data/h;

    invoke-virtual {p0, p1}, Lcom/taobao/monitor/impl/trace/o$c;->a(Lcom/taobao/monitor/impl/data/h;)V

    return-void
.end method
