.class final Lanetwork/channel/aidl/b;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroid/os/Parcelable$Creator<",
        "Lanetwork/channel/aidl/DefaultProgressEvent;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 111
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Landroid/os/Parcel;)Lanetwork/channel/aidl/DefaultProgressEvent;
    .locals 0

    .line 114
    invoke-static {p1}, Lanetwork/channel/aidl/DefaultProgressEvent;->readFromParcel(Landroid/os/Parcel;)Lanetwork/channel/aidl/DefaultProgressEvent;

    move-result-object p1

    return-object p1
.end method

.method public a(I)[Lanetwork/channel/aidl/DefaultProgressEvent;
    .locals 0

    .line 119
    new-array p1, p1, [Lanetwork/channel/aidl/DefaultProgressEvent;

    return-object p1
.end method

.method public synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 0

    .line 111
    invoke-virtual {p0, p1}, Lanetwork/channel/aidl/b;->a(Landroid/os/Parcel;)Lanetwork/channel/aidl/DefaultProgressEvent;

    move-result-object p1

    return-object p1
.end method

.method public synthetic newArray(I)[Ljava/lang/Object;
    .locals 0

    .line 111
    invoke-virtual {p0, p1}, Lanetwork/channel/aidl/b;->a(I)[Lanetwork/channel/aidl/DefaultProgressEvent;

    move-result-object p1

    return-object p1
.end method
