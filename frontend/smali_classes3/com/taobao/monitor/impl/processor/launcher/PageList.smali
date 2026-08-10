.class public Lcom/taobao/monitor/impl/processor/launcher/PageList;
.super Ljava/lang/Object;
.source "PageList.java"


# static fields
.field private static blackList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static complexPageList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static whiteList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/taobao/monitor/impl/processor/launcher/PageList;->blackList:Ljava/util/List;

    .line 4
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/taobao/monitor/impl/processor/launcher/PageList;->whiteList:Ljava/util/List;

    .line 7
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/taobao/monitor/impl/processor/launcher/PageList;->complexPageList:Ljava/util/List;

    sget-object v0, Lcom/taobao/monitor/impl/processor/launcher/PageList;->blackList:Ljava/util/List;

    const-string v1, "com.bumptech.glide.manager.SupportRequestManagerFragment"

    .line 10
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    sget-object v0, Lcom/taobao/monitor/impl/processor/launcher/PageList;->blackList:Ljava/util/List;

    const-string v1, "com.gyf.immersionbar.SupportRequestManagerFragment"

    .line 11
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addBlackPage(Ljava/lang/String;)V
    .locals 1

    sget-object v0, Lcom/taobao/monitor/impl/processor/launcher/PageList;->blackList:Ljava/util/List;

    .line 1
    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public static addComplexPage(Ljava/lang/String;)V
    .locals 1

    sget-object v0, Lcom/taobao/monitor/impl/processor/launcher/PageList;->complexPageList:Ljava/util/List;

    .line 1
    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public static addWhitePage(Ljava/lang/String;)V
    .locals 1

    sget-object v0, Lcom/taobao/monitor/impl/processor/launcher/PageList;->whiteList:Ljava/util/List;

    .line 1
    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public static inBlackList(Ljava/lang/String;)Z
    .locals 1

    sget-object v0, Lcom/taobao/monitor/impl/processor/launcher/PageList;->blackList:Ljava/util/List;

    .line 1
    invoke-interface {v0, p0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method public static inComplexPage(Ljava/lang/String;)Z
    .locals 1

    sget-object v0, Lcom/taobao/monitor/impl/processor/launcher/PageList;->complexPageList:Ljava/util/List;

    .line 1
    invoke-interface {v0, p0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method public static inWhiteList(Ljava/lang/String;)Z
    .locals 1

    sget-object v0, Lcom/taobao/monitor/impl/processor/launcher/PageList;->whiteList:Ljava/util/List;

    .line 1
    invoke-interface {v0, p0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method public static isWhiteListEmpty()Z
    .locals 1

    sget-object v0, Lcom/taobao/monitor/impl/processor/launcher/PageList;->whiteList:Ljava/util/List;

    .line 1
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    return v0
.end method
