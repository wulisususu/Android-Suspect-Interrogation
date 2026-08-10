.class public Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$SingleTon;
.super Ljava/lang/Object;
.source "Event1010Handler.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "SingleTon"
.end annotation


# static fields
.field public static instance:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;


# direct methods
.method public static constructor <clinit>()V
    .locals 2

    .line 274
    new-instance v0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;-><init>(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$1;)V

    sput-object v0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$SingleTon;->instance:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 273
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static synthetic access$000()Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;
    .locals 1

    sget-object v0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$SingleTon;->instance:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    return-object v0
.end method
