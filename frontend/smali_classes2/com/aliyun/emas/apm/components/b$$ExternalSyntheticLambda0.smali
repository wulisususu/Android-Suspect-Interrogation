.class public final synthetic Lcom/aliyun/emas/apm/components/b$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Ljava/util/Map$Entry;

.field public final synthetic f$1:Lcom/aliyun/emas/apm/events/Event;


# direct methods
.method public synthetic constructor <init>(Ljava/util/Map$Entry;Lcom/aliyun/emas/apm/events/Event;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/b$$ExternalSyntheticLambda0;->f$0:Ljava/util/Map$Entry;

    iput-object p2, p0, Lcom/aliyun/emas/apm/components/b$$ExternalSyntheticLambda0;->f$1:Lcom/aliyun/emas/apm/events/Event;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/b$$ExternalSyntheticLambda0;->f$0:Ljava/util/Map$Entry;

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/b$$ExternalSyntheticLambda0;->f$1:Lcom/aliyun/emas/apm/events/Event;

    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/components/b;->a(Ljava/util/Map$Entry;Lcom/aliyun/emas/apm/events/Event;)V

    return-void
.end method
