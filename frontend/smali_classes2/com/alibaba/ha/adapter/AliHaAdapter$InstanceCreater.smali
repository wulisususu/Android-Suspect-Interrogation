.class public Lcom/alibaba/ha/adapter/AliHaAdapter$InstanceCreater;
.super Ljava/lang/Object;
.source "AliHaAdapter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/ha/adapter/AliHaAdapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "InstanceCreater"
.end annotation


# static fields
.field public static instance:Lcom/alibaba/ha/adapter/AliHaAdapter;


# direct methods
.method public static constructor <clinit>()V
    .locals 2

    .line 64
    new-instance v0, Lcom/alibaba/ha/adapter/AliHaAdapter;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/alibaba/ha/adapter/AliHaAdapter;-><init>(Lcom/alibaba/ha/adapter/AliHaAdapter$1;)V

    sput-object v0, Lcom/alibaba/ha/adapter/AliHaAdapter$InstanceCreater;->instance:Lcom/alibaba/ha/adapter/AliHaAdapter;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 63
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static synthetic access$100()Lcom/alibaba/ha/adapter/AliHaAdapter;
    .locals 1

    sget-object v0, Lcom/alibaba/ha/adapter/AliHaAdapter$InstanceCreater;->instance:Lcom/alibaba/ha/adapter/AliHaAdapter;

    return-object v0
.end method
