.class public Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$1;
.super Ljava/lang/Object;
.source "Event1010Handler.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->init(Landroid/app/Application;Ljava/util/Map;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field public final synthetic this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;


# direct methods
.method public constructor <init>(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$1;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$1;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    .line 56
    invoke-static {v0}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$200(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)Ljava/util/List;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$102(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;Ljava/util/List;)Ljava/util/List;

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$1;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    .line 57
    invoke-static {v0}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$300(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)V

    return-void
.end method
