.class public Lcom/aliyun/emas/apm/components/e$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/events/Publisher;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/components/e;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation


# instance fields
.field public final a:Ljava/util/Set;

.field public final b:Lcom/aliyun/emas/apm/events/Publisher;


# direct methods
.method public constructor <init>(Ljava/util/Set;Lcom/aliyun/emas/apm/events/Publisher;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/e$a;->a:Ljava/util/Set;

    iput-object p2, p0, Lcom/aliyun/emas/apm/components/e$a;->b:Lcom/aliyun/emas/apm/events/Publisher;

    return-void
.end method


# virtual methods
.method public publish(Lcom/aliyun/emas/apm/events/Event;)V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/e$a;->a:Ljava/util/Set;

    .line 1
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/events/Event;->getType()Ljava/lang/Class;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/e$a;->b:Lcom/aliyun/emas/apm/events/Publisher;

    .line 5
    invoke-interface {v0, p1}, Lcom/aliyun/emas/apm/events/Publisher;->publish(Lcom/aliyun/emas/apm/events/Event;)V

    return-void

    .line 6
    :cond_0
    new-instance v0, Lcom/aliyun/emas/apm/components/DependencyException;

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v1, "Attempting to publish an undeclared event %s."

    .line 7
    invoke-static {v1, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lcom/aliyun/emas/apm/components/DependencyException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
